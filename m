Return-Path: <linux-wireless+bounces-37453-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YG47NtBCJGpY4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-37453-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:54:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD464DDDE
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:54:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oT8dcKgz;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Oy0onTq7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37453-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37453-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEBD830316D6
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 15:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30F537BE6D;
	Sat,  6 Jun 2026 15:54:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379B3B583A
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 15:54:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761247; cv=none; b=n1cXzrxu0P/vT1hhPLjHD4+nIbn3pzNs4R5w6D1NaufoK6A1C5IDyyL/wT+Q2tH/rF47jxws+FWNgHSEhpbussYE3bPMdB/WdkmqBRRJa8ELXyMVKC35yNXOqxUPJVNSK0RY5nQtRuD0SLh+1Lc52Vuos2YlCmCtvG7JyOAkiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761247; c=relaxed/simple;
	bh=QbI2iF5ATqukAm8/OrTVZIMKo6vshlTFEvvLU8DKqtw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y2Ndvvb6oJIswcMn1JF6wKMFDF0KhdpDFhK5TjvPYayFNmTEkaJGKERuFzHSgEG6cR4Gni5TpMy8CyUZs5rp6PcPSVIzdatZYAmWliyh/XejAW1CposNCQppAlq74NLU9oPaVoVL3kdq8KmeMuXqgK7fMnRyPRUi2k5vBUBbgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oT8dcKgz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oy0onTq7; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656EuQoa2179807
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 15:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mch5hVVaCuY7h4YZozTTR2WoAtxqCjl+e8MtIhQY8Hs=; b=oT8dcKgzzI3xGcT3
	3khaSHJZdAkojWdcJ4MXKgVeo8lNEVbTz/QqUclo/9JU7/LeuVwvH/tdA8sninow
	bNy864X5F55aYoS/0MlqswPWXHO7posTuBDDY5h7+jDYAau8Rh8gBKrDYQSEB+/5
	03zvQ/EQfmX95/7JtETCC7eXcOyrJVkL5f75/j9ClsTWvZyUaxVBTWO3nu8Hz+wi
	IFx0n8oLBj6A21qgSrN6x9NxbIFZUtmC5pA1BwZE6weTRyj4ZLr3e17IDjacfNgV
	2Qqr+xZeu6t8Y53ZYtMLzukxyex9zc26ZUjcX6AYXPteqU9GchFwXB5JPw94W5AI
	D3oYPQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w1q5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 15:54:05 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304e7fc90b1so2788984eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780761245; x=1781366045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mch5hVVaCuY7h4YZozTTR2WoAtxqCjl+e8MtIhQY8Hs=;
        b=Oy0onTq7ZG2Cw/9LUs5yFKB5XNl0kndkDoiex5kxgFzkCP8n9FmT6UQxeHJnL3QQFN
         4idl14ZrnXH49I3S/f7VikpE5UAYo6RUAa1M8WcYOAuBVBGGyEhLjw/I7z6iWjMwHKds
         2cwX9ol6P0rL3pShy3DGkwbwvmsqA9OoaiT/KJA4is1dxRFo9Hr0WQYlJLVmDwAnL1Er
         C6riEH/A8pUe1f6fD6qTvY76Pz1KnXh7jd3iVgcCi1b9Mbs0by1/py6QdKdGpoyMrF0U
         w48WPVin/fl4/wKQOmbQKhAMJ1Zju0hXtAlOUmhfb5SNBo+/L9rvcVWqqdcDpNicWXDP
         mkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761245; x=1781366045;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mch5hVVaCuY7h4YZozTTR2WoAtxqCjl+e8MtIhQY8Hs=;
        b=q6ZUP94pQUCPPMxu4mZQCRaa8T91zIC/P1d2A8w7VYt0RaOETpmy6+W/lgoPXYcukC
         cnR+Wha+87kuJAVYhqmXhdn5k8ThrUMtLmr7Z8NJu+/XX4QVSBEFsT91hbKmZOt97bAt
         c6FHs3A6Uv02TdEZ+WOqTlV4at2WzZ3sXffFtLa2X8DU7FTeQv/OPq6DbeoLeEzd2SC1
         3GXgXYcc0Fiy8I/IZp2ie5e21Nxn4O8RTwsOpyT921faqZ1RBp8mlqWP6H3hkSAaSB2B
         Gdw/Lzrfuc/X82CiXpSmibpWjAfX71f+ZlY7zLek7NaDNQL/zUGhdZCzSum86lTOv2IG
         35FA==
X-Gm-Message-State: AOJu0Yyj5YRm5L5H5OUYAx38ONGlMkKGLripZ4uh/pzApflV2EnYQT1C
	3HrnOhR5xFAcNewVzyFyLcNPvU98/VmmFhNPm4QPZlxVg5QyVpeiPXjDVib313eUBZNUCLZ+x8q
	AFINZ8V3eaGhev8LaONYbGPsL5H2vzyKd1MwG5CggSFK8gaWDV7zm8DLtndDbZmyFrps/mA==
X-Gm-Gg: Acq92OFTa1KlKSWujSe1aMNMT1IxNlELAgjASqEXI5X0aGaeUsQoJUptr0v+CyCHth3
	ov1tKrFehJDK44YZNymEl4NWph7sMd3Z7lNrk0YJRKJ6abSvXZunDM6XRDPdnBuQZ2Cufia/ljL
	ihhXDPSyx65XllWWK/+JHaPHMmV+W7bg1I1eH+SaGkgYsqxpEFOU4iMYmFASZWCxRYUbXaZMhmZ
	YYCRUwbNMv9nNOQZtXzXghmu8cPkqBVqIbJBT1ULohFFrq18UEjvxxrBz9fDMryAIUiX/cq5o+C
	iDUro3560gtXEoGg9OW9/C2GcfuJOE3rh9s9oe1OTDUoMkUby+Erc4ONBbTRkxj7oQmJS7pA9wk
	L3HBcBaFgZOZz0sXWo34NE6UJmFQuU+9hXGnp1SW6fyx0PnuKyKPSLQqS0u3zvl45oQ7y5LziU/
	7Se1VTpqbpXog=
X-Received: by 2002:a05:7300:72c9:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-3077af330fdmr5360593eec.5.1780761244525;
        Sat, 06 Jun 2026 08:54:04 -0700 (PDT)
X-Received: by 2002:a05:7300:72c9:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-3077af330fdmr5360579eec.5.1780761243967;
        Sat, 06 Jun 2026 08:54:03 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm11240392eec.24.2026.06.06.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:54:01 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260506234848.189840-1-rosenp@gmail.com>
References: <20260506234848.189840-1-rosenp@gmail.com>
Subject: Re: [PATCHv2 ath-next] wifi: ath9k_htc: use module_usb_driver
Message-Id: <178076124092.768205.13153571382920707351.b4-ty@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 08:54:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: e4kQYAxM5Xcxon0ZLMTfhv_j5NJ35s5y
X-Proofpoint-GUID: e4kQYAxM5Xcxon0ZLMTfhv_j5NJ35s5y
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a24429d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=TjsKobitn0EmYbxorvwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2MyBTYWx0ZWRfXxfjX7diaZyoS
 uWOUqO7MZeHWImxTkvwT9OmFYBoJ2Sa8gZDrkClScE6dWT7BTkmZ/ovrJwIiPX9HXuqHZhS9sQ3
 ubK86yf0Be4uGDwRQNcOXOrbCMwErOL99eRCil2TgNSNYDEoUP6hBNxJL2G0YanMdVRMSXcisoc
 U/qJoRg3Gp6fqDvZTFuWM1tCR8gOkaKakiwSIQcgds2/44XvW+xnKPfeiILEcr1t0JWBN0vDQTc
 HX1RUxn1EZI2Y+p9HloqYIFS23mPCZ5MUwf9HMs1LL06Vs99PaKX1FVLh32cYd4nEb0PTyAY/H2
 DDt433gwG94E+7v7eq1nx8Z5BWW+I5AA8Z/fYWa2YZW4emNbsjcabTpr2t84287WxH7p+3oYaEA
 gnUEqdk0dAo588zhbkzvtTi32UifCHd/CXvPuTdiJC3zrrqY3cUqc+5xs3vY83KwPZqqBtL3cuv
 2pljE0wRgYYb66Rz9iw==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37453-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:rosenp@gmail.com,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55AD464DDDE


On Wed, 06 May 2026 16:48:48 -0700, Rosen Penev wrote:
> This follows the pattern with other USB Wifi drivers. There is nothing
> special being done in the _init and _exit functions here. Simplifies and
> saves some lines of code.
> 
> 

Applied, thanks!

[1/1] wifi: ath9k_htc: use module_usb_driver
      commit: 6a03ff9d5765ab701c12c9fc781fa6de171e1a2e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


