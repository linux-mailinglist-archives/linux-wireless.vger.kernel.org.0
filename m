Return-Path: <linux-wireless+bounces-37458-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H1azLXlDJGp/4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-37458-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:57:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCEA64DE15
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pUQyr1fo;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="cUb/3qdH";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37458-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37458-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78523060491
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0FB3B52E6;
	Sat,  6 Jun 2026 15:54:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C123B8D48
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 15:54:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761259; cv=none; b=f2kOiwwOHb0WV2AuzHLVYnS5n7aoDb59hv53GhPAO6FxxHObaX8PWre6x+Z/n+aVXvbPWrb8lsercDoV0yL4+PX7nd02gEIihr/K4F2XG0iOyT/6+ZRbWFOLLU1bHApYGa6oJVNhUSjgP6WJ3VtCV1oi3fQJ5NxhrK0j0W2Tcrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761259; c=relaxed/simple;
	bh=xIZYsiCxuxqH2511OFYEZ/HwfoyoHv7PtfKMDgsd82c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=khNeMjE8fRwMpFmtRnJ5r/s1TDTWuuwU1ERh23SPd3Jg+Tp5mX199MOd3URk4UNfJvi0fXLORyqifNj6xYh+G6xc7b6wCYn+zP7DIS4KR4OCkzeeZi+6bzROhPngsYUNl4/LIObxT3iOmhQoMvDCUmnGl6mLqZp1pTMlkKcMZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pUQyr1fo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cUb/3qdH; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656EuRu12180049
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 15:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5JeOnqcyB2ZNwGZ+ck61CkLkuAUnGvQFSt0GN2rLAZo=; b=pUQyr1fof3JsFyWh
	F6MQLoJQUW2BOuH8mHNDl4loRdw0ElBdF21WDVLSbiwlF7R4AsLttkWw+EVF7kqK
	pwZSeD2qRhurxpeUAQGcvJx/OU6o2xUg9FOZFUcBTe6TJ2HgjRGme9MGO4s/erqB
	F5/2nNU4AZ0BQdnrGmv1UcR9y+Q1LlOkOyyu970DaC9RnKvs2f+dlP8sUyc5ycli
	wQbbpY1FCc4o8CdhKvKMblVVsW+kiv2lP0IB7ABvqLUq9oPjXMLV1M8WoJUZjopi
	hugkQNLDZpOu5Xqq13rrWINKMNZJvvDCClklsBBnvTcUFXpeRKHzfLxzTpE+6EQr
	fsUoQg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w1q6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 15:54:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304d8613efbso2889757eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780761256; x=1781366056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JeOnqcyB2ZNwGZ+ck61CkLkuAUnGvQFSt0GN2rLAZo=;
        b=cUb/3qdH6KwDlSR8h0TA1d3KoPi3AudRzTWBaQfXE2KAld3rfm0LM3sXTPW71OlPY2
         lYvMtDwyLJK9LycGNAUrEb6WDCyoMwDLNxLGfGCUFbf4665RhRfwEE5ZiHbHj6z5N9p6
         0krysMsaYDZuW3SlXEBzXAFKGKUaJfUZbKuX/jdZJqYL9UDB9IPJsoMar03ROU3GaoNe
         PXGECrqLQDkqeB/z5S0RfuZwbzZamSlzNQPfoLmocDMGFdc70mzsXnL3vPdM5jVgV3Tj
         0SiQl+Z8lteDB98nyWqfjbOms9FEIc/BXGCY+x5nirW1IJses+0+6B7Twf2qs4cNzQ0V
         aD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761256; x=1781366056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5JeOnqcyB2ZNwGZ+ck61CkLkuAUnGvQFSt0GN2rLAZo=;
        b=IRPXmD5k06v11f+Ra2p8z5h3+Jb702SpCANIlZauGuPSEsgQVpLuibycuTJoRFHz+H
         cK4JH4K5+p6BjAP2dAClJ776am04tvileShLrCVtM26NhBGQEKr7x6YvhZ8XH7pwHoSt
         imVeLHzHyAmpRZ5nA0CgI/eT0v3PgKatTAcBuyIbUbpHE++4asvF374TPMhjTPA3QTfY
         QYukuhcorS17Gi1bLrqjS0IEzBnMmhL/v9ef0S0elbVi+kSfYXudF6QMFwoAk+WGpgPi
         vhh4jhcccL8v2JmJLSv/IikiacNulHC9ioK76tS1eTQSfXLUoil6+sjmAbaraBAEEpsn
         1JPw==
X-Forwarded-Encrypted: i=1; AFNElJ+58tFVnoJp4rmq4xRQDXcrgnzLwoClaWgAQRo5BeC/LZiOI7ECkRLLz/TJNvBjmCr2JUSX9LOqPicmVRST+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJN9Pliz+AEkh+BwWnMZGoCvSSJvh3ReNPVo9NJel6YXlgO3Q8
	Lno4j2uMrk6K/uD0ZSPsFWjrDLri4thlYEixWF3obv8XL3Y2o4lRviXkgZ5aN0vVD2MS7QWXJLN
	5wMv2x8mEPWX2QxFQahlCHk8oVDqVaSZHZEJG0oUbn+7DeqND/GMFgoo/2GCAMcx04e4cyg==
X-Gm-Gg: Acq92OGdQa1yD4VnFrey87eDqkKhXwx1kYprXo7Yp3dbywbeb4x6fcL+F+dYJ6NLGp3
	S6yrDmdtuDbTfJ6X9diYDgfWGXXuJIe6MDW/ZPfjZeV69k3ZdIEsHYjIZjqW3WOe28JY2VbAHF2
	sU5sU6MkRvgs7PpBF+lkCxv8hhhyU5JYkRhv9aMmwrNvg9W6lJkmqS7ZG6bmkt3OpkxtMBQKYTd
	S/K/xu9zdPMYnjddqqcjJXKrp/8S/gq9FwTO/d7ZNcJ1D6axInNnZYqhotum5DCmyuD0lSJvN/o
	n5fjlLCiSDklyXIhVsvMquOCgdogwXOpN4TkOfKmPuiEbCOa86dptJL8tztSb5kkTa/3GVLHczd
	RMUmSGelR00AdZhTCeBwYe4Wvco+HbT7YZHRYA8GAfqIUkY7ZmuKLtMacWAkCEP95DsKPfVSg5F
	B1xKdfmQdotxs=
X-Received: by 2002:a05:7300:a198:b0:304:d75b:f5df with SMTP id 5a478bee46e88-3077b705155mr4758124eec.19.1780761255691;
        Sat, 06 Jun 2026 08:54:15 -0700 (PDT)
X-Received: by 2002:a05:7300:a198:b0:304:d75b:f5df with SMTP id 5a478bee46e88-3077b705155mr4758114eec.19.1780761255196;
        Sat, 06 Jun 2026 08:54:15 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm11240392eec.24.2026.06.06.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:54:11 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
In-Reply-To: <20260421135018.352774-1-tristmd@gmail.com>
References: <20260421135018.352774-1-tristmd@gmail.com>
Subject: Re: [PATCH v3 0/3] wifi: wcn36xx: firmware trust boundary
 hardening
Message-Id: <178076125181.768205.1715768745486445961.b4-ty@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 08:54:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: pEGd95EITvhvcOIWaB30LHI32HZDtaMU
X-Proofpoint-GUID: pEGd95EITvhvcOIWaB30LHI32HZDtaMU
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a2442a8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=guOGsJC-GG3CFDDRhA4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2MyBTYWx0ZWRfXwTosyhXCxanf
 TEt0VHGHjeJxEMnym/XF3Bai74hyQ56n2JlC6WqaXoYsEKiOr8aajinFSJGLta4i7/ZCwKFmf5o
 ZIIN8/ZqNeg+ma4eHBQubq3RJemX1rf4unvvpVCl5di3D8/scU/QrVBi7mg/Ivg3Wec6EVmU74c
 Hj+NR5Ie+QEWL+JouKINVk5IG0xcEklXFvDNFR3YnRx8zkz26nm6jzMANwSkERDl6F/xLrMpqhk
 DwWJ8QjYNqCgVfSpufL0ktkc93KChamyIJF0NjAFGtc7Ru3bagS0coS5AdNXMdRRuz75UCYJYhI
 JeUv4xqzJ1FDqzP9Vk7V0CBGRpJDQ5FyL7cyhkqnILMmsjawy/DviPqOPt9X1vGh6QYstSMUZum
 GrVVIoaf7VJ1HY1VxaiVvJxAYjaIH3AquZSTcwqAtHc3ABf+vgU6TUmWtTe1DvtyUj2xe62YalI
 IEdWpuS8Pw5UfVvF77g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37458-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:wcn36xx@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CCEA64DE15


On Tue, 21 Apr 2026 13:50:15 +0000, Tristan Madani wrote:
> This series adds missing bounds checks for firmware-controlled fields
> in the Qualcomm wcn36xx driver.
> 
> Patch 1 prevents heap overflow from oversized HAL responses. Patch 2
> validates PRINT_REG_INFO count. Patch 3 checks trigger BA response
> length.
> 
> [...]

Applied, thanks!

[1/3] wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
      commit: 88a240d86d3d64521f9194abe185ac71cc74d0bd
[2/3] wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
      commit: df2187acfca6c6cca372c5d35f42394d9c270b09
[3/3] wifi: wcn36xx: fix OOB read from short trigger BA firmware response
      commit: b5e6f21923ca89d90256e7346301056f6502691e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


