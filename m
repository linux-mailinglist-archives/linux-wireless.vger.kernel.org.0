Return-Path: <linux-wireless+bounces-31379-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIdyCpjLfGlAOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31379-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:17:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68659BBF40
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1F483019A84
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80DC37F74E;
	Fri, 30 Jan 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IN/hpPK2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMTQs39J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA211E98EF
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786145; cv=none; b=F5urdC4I21uAZ8QLW9hAByzrvc/i/Bn3rDysytoYsWJIqqGeIUS1fiSCwcU3sVHDj0Njd79BVNkA+yN0tSTs4YutYZLa6TyBY0W3Z9wxM1VfAytzfgT8Od3XLkUuELLtILWSiNuCcvk5gZuWUrSZx6qUYE5PoB/94iKGqnQs3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786145; c=relaxed/simple;
	bh=aOv2+BqBT/0znw193X3rxzhrUURj53FvSoRi1IB8O4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MNRKmgg8IfBSZGOMOOneaQDt71SBL2E8skc+pyFkTBpPvaSi9cRNco0kYIkm9LwTMq9gLpyAGNoymgJvLUZSGDKCF+tML914H6naHKHNlsxgKdyLj/vU+tcVoUA0cos30DzKKMjGyNlnXsRIfKtbG/uyA2ZOvMHzciB3siYqql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IN/hpPK2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gMTQs39J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UB4eLo485896
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CTcY81yIclkYNJ1+nOOS1HT+sbXHp33WP4xB6dvakDw=; b=IN/hpPK2ioBj33UC
	1PJAhAKz5hr2lZYfPetDg513pWzuuIPHbBB1Y7y80TNVrKtj9SbObGLT2Kwogi16
	lbiaQ5aSkRAU0DufiIQPnAQrZEPTHmfLErv5dMxVIz4J5IySITx95/V51eZeyoA+
	0RldFPpA5LHIR2EsJKZDjd7DnSUWZpNK5OQesxj2imfR3P9d4LZL8zMJN5Dpzzaj
	BurKgRVlKNI+E9zfZZnv+4gi7rXs2rCbsBaDIZPmsXwM7ZNFwa6uzJQq7xrpGaeE
	WzDKtaQpkWh6ooHyyzRXHwMc1J35pnoUfY+gC5AKn7FwNP/NKJGy5g9qRWSbomcV
	+ufjEg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gtnjkx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:43 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-123349958b2so6001227c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786142; x=1770390942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTcY81yIclkYNJ1+nOOS1HT+sbXHp33WP4xB6dvakDw=;
        b=gMTQs39Jr1sVs9pQiboaH/iGbqjnPfUNqo0ozFJMe9yXLyPpx7utR5skIdh1Y4W75t
         6Do3og14KFiJbihQOozr0IjgRVPZtTdOBszwG/7uYAia5gdjcUJDTCw2fyOQAYAA2w9r
         1C31dc/pUi6R4pwTkqxaI6xxuF1NqlMie/S84UxR2QnY/jwFPwmL00e2Ot5MOnuU8Z04
         mFCYx2e50IHswLNTSV1W+MVDvDE7ZnX5eiqOZgfSx5hjj5otcEWJrARfO0ZTR8NWvdmY
         FuvVolOFrc/hCU3VmBzhAqNFr47p/BEPHPW6G6wyUGh6MQCp2jz0yMRRtqfGcAthtGZy
         rQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786142; x=1770390942;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTcY81yIclkYNJ1+nOOS1HT+sbXHp33WP4xB6dvakDw=;
        b=kgkMuvaawTm1ipdH/Tl93qU4qgkLNmZV+SFWHaPGxVXkhrK5byTRK1mvjOXtVNo8jB
         OYBW9KBop1aK7x5BgwnRiiHmS/nPJAZf+xXcz7arpYlSBmofnSB7dZ4Sw1r0YdFgu9um
         AFU7rgbx7I5rb+Zgg1R8bbIY/EoitQEvhmMaBHVG+ZS78hf81zle6n31wZHI6Klhm8ML
         qQYZrefozciQsGtfdLv2gq1nK6G+5QXsSTJpDdUH2l3zy8FOdHeSnYXJ6DA1RcM7cL7Y
         CajQVCtFz3mNzaWw7amXXyOtHOHqMkHP9sGyqiBgEzQ8YurICBJzF6NoLFgl5BwyLb7V
         J6Uw==
X-Gm-Message-State: AOJu0Yx0F4/+UGzpWvN1CdnQib4dEpCBsRepVFIVQ1Ym9cILr2157He0
	gFQHDCs/47COqBcrxZBMg4DunnEoDsRjfyEJU9ZdCJ7jUAF6urzm6+ofkdplu6ougWqsCQRrtWG
	9bQZca9Xv0bBqvX4iesvVJjS3metdOG0POsQXnwIncvqpa8jG+3jm/0fcAh12AE7ujGN7yCM2lJ
	3UWg==
X-Gm-Gg: AZuq6aK4TmUYpzSg+qob/TYEHhMmTtMvICfHSJXOaebLeE6orwDI5TZcKwNxjjPh0iG
	XBlUUemoC/AP5DB0WM/+nBGfZBXY6YgDV3vdLWe0V1pT/xq6uzS4ufQIRc4BOUPQqdfGAcrpwI8
	tcYSK7yTGtNJe2HzrSlv22GWR8CbXUHuorCv5nfpvLy831ZgBkn4OH5tV6vJYaXdWZwxv7+CDo8
	XFluSOWL1WOQ+owaq4M9xooFAkfBKZsHbwwXPgazjq5dxzpHRgkgPET9hUtZa3xk3IjKKeFq0Ro
	9ofMDiUIhMee0/hy7iewCFQ5Z2UgL8bx7mr6JPzkUmFoEP4r2FLSMJ28ME/zWyQcBwcXdQjv1K+
	rkALHeXN1J8vBEEQATfV+l6rbj0EGDmlclMngNWPLh8xtohvl5ibpy9tiTX2K6qtz
X-Received: by 2002:a05:7022:e25:b0:119:e56b:957b with SMTP id a92af1059eb24-125c0f0dc62mr1667958c88.0.1769786141846;
        Fri, 30 Jan 2026 07:15:41 -0800 (PST)
X-Received: by 2002:a05:7022:e25:b0:119:e56b:957b with SMTP id a92af1059eb24-125c0f0dc62mr1667938c88.0.1769786141268;
        Fri, 30 Jan 2026 07:15:41 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:40 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260127033400.1721220-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260127033400.1721220-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: clear stale link mapping of
 ahvif->links_map
Message-Id: <176978614056.3951544.9534320708366481155.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:40 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: t8h2Hj1hBZJh7OrqfjRJlU-8LqrF00JH
X-Authority-Analysis: v=2.4 cv=FPcWBuos c=1 sm=1 tr=0 ts=697ccb1f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0KSZRMCv1EX8QH9XOcUA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: t8h2Hj1hBZJh7OrqfjRJlU-8LqrF00JH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfXwllKZBSA+M0j
 ejo5Si1lMae8oJ1CNdbx8IkIidCTxsvCqPQQV27Hv9571xgVn4Az4duLiIkTQaQisG2/LIVnIDL
 X+j6V/BMUCj1a8mOTOT5BkcGGYp/L3kdcVSF0KlXhZsCiYjei+akozRzxtbSZK0ilJWmwTjIdkY
 A7UMWoY3BmL3xVOw5AkGE/WGujq2ES9qtH+8xLY9orsB27reoBzBhEQY4o6ITEQ0BtrYcrKLIRc
 DOZBlsEmQNfz2BBe8z512MIkH9vNZKC5iIOJw+SEapBJNU7ro4Jq1LtEQQox14/h53U+2jxRQCA
 OeBvfx3HiRcfK1Ha9+545zgulV23P3HEYKFPpghnXXh5iahAFPuNjughRQiM6eGZBuLWNG5b3rE
 ak8rVXUOhF+tTl1hVgyMEDL73cIT3lujvUbH63lnkevGidAN4Qmm/8MkEBbxLA5N+XEgge9YLAJ
 J1VJf8abuexuMxuXnMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31379-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 68659BBF40
X-Rspamd-Action: no action


On Tue, 27 Jan 2026 09:04:00 +0530, Aaradhana Sahu wrote:
> When an arvif is initialized in non-AP STA mode but MLO connection
> preparation fails before the arvif is created
> (arvif->is_created remains false), the error path attempts to delete all
> links. However, link deletion only executes when arvif->is_created is true.
> As a result, ahvif retains a stale entry of arvif that is initialized but
> not created.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: clear stale link mapping of ahvif->links_map
      commit: 2c1ba9c2adf0fda96eaaebd8799268a7506a8fc9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


