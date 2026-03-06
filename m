Return-Path: <linux-wireless+bounces-32662-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KzYF6BJq2mzbwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32662-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:39:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B16552280EE
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D5D930515E8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 21:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B648AE3A;
	Fri,  6 Mar 2026 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pbj0w1kW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LnQArHWt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D1344056
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833180; cv=none; b=SJ/HqvBsDPP6YSUIkTjTn0peETKnZx3wkQTAVD55NO/WGheRVkJ5rVng8fzpAOMJXNjlQfqPKOgec6iNukh6a5PiZzld9L7Bz9FXjNLTf3d2g4PccuVr9o+DJw6ANw1s8f6fpNvD6nrDbZaFwtxUQQGyfTNIRRlpZoAWNNe/4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833180; c=relaxed/simple;
	bh=y9lwu8NiuYdesQCgprGV36ulvdHYqH9WXGseuu0y9MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7tWnN6PVykvuNlYd/QmEKaoay5OY9E0PPSk56X9u6pLdmS05/OdXEIlvyE9+1cN9OumKVTR8Y9iEUPoBdioSNK4Ovb0fn/y6dVOfWPU9n1Ug6b9n9Fnxn8/XrPg3h4JtZ6WXNfjxrxggcTmhDCBr8ayCx2sBynrtWadN4ftRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pbj0w1kW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LnQArHWt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KWW3w3192961
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 21:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMkU+4O21mSQ3lkP6yl/iUl6aZcUeJ/Rm0S5HObAZCI=; b=pbj0w1kWHHRb8I7D
	dfWYcpCQdGxNFADtjV/1azHVBRSkBDVSzDNurXi01erOFUER1P+Ydr+8NM2w0dh+
	4mZ/gRPwz+EpZ1sbaRqsxklZyBmf2vETV+MFx/fGtLGwvXq9QuTZvKSI4Gdr4ZvN
	4cXzQo9JP39mLUMhfRhGIwCNjPbLwKfOlNU4dEOsj7oZ4d/dTI1/8vw3zBLTHSpV
	/kWM+fHP+S+1AM9zr5P+g8yX+KwB4HY78vE4ym49g9sTulEy+o43zO/czvdiVSEq
	OSzDQNA2ItYzHC8BnV/mMDP+5vUgDlppD+nZO9nUWtOrfv2yDxGQhPYVcwBasVHo
	v/U6RQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr2utrvvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 21:39:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2be0575e290so5451617eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772833174; x=1773437974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMkU+4O21mSQ3lkP6yl/iUl6aZcUeJ/Rm0S5HObAZCI=;
        b=LnQArHWt2rL5aVNwFfIJIj/6yh0zsblQx8cOC3l8gn5AbJaUqFXj8QeWGsikDWyIx5
         ++y+paxWxanOdfeyAH6kBcc63X51HkTlxLdk1f3iC6OdnQYCWzIfqCW2GlI6Vgm142wm
         C0QhAloHrJqd+WJfqeNa14pXS6yM8a3BqOU36+OTn7RRnWPOUaEwWqsSkRQJlksTn4Hg
         vHUet5SEwAuecuXZ6z8SOSFNLF15RenJLgKkp0fQew+YAKDL716Vlp4Z95UJ16T8xPbe
         xVEW2SJuJ8ccHSmWeYwSu7pRj5jnNCKRfYthj/Eu39Zjdhbs+8mwEAvHB47FUg8L108M
         2Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772833174; x=1773437974;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMkU+4O21mSQ3lkP6yl/iUl6aZcUeJ/Rm0S5HObAZCI=;
        b=b4mRnHgT8YXz2dVCdm/yHDhDSS3L9bqoQF5LagjnN6Rn8YZPpM9Bn0AYD5LZmC4si/
         0ak8SuBB2STMUKkCkM9w9kVGnrVXwsHV78Xv+yccgGubsNNdZMdqrq3saWg4XQpFWqTg
         np6xzFW/DiVl1sEjpXFg20As76HVji0PwoejdhzINYdLCQHUx4739jBqPVnW5dPBXDuz
         oZ+SNKuzVVWALbIa36hXO1MbH5YR0imrXQgN9WnNYoyWlVLfKHouAIMWtBBNcLKMH70w
         XxkYd//Mx7fFwxpuzVwHqktBiEavK/hOL5vXve8TVPuRRqmPi5QIqO3870NZ8sE8VJ8t
         kPyg==
X-Forwarded-Encrypted: i=1; AJvYcCWKMUiVScAtSymS8JsZJlrLDS8rDItNBOkp3GSPv+NPmzG08n8Pje8mWdUb4wacS33JQOWry2K8bJx1LR8C5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpaeZmivmF3HPUTePNZ52bhJ8pRRQWohEL1TEyssbf77yGUU+
	ct+9iN7kvZZdm/KWjkIQcapGE3ycDkYAq0+dPJU/zB833TcrGpwHq8ofplfnzHHWbddNsyfvdVE
	hRQiRpkzILt/ig6nwMiUOPaYgNBbabluLnat1VcDg5FolsBiOPBeQU1cHKUkHic6Vvs0PVt1bvU
	JIfA==
X-Gm-Gg: ATEYQzywflGflhejTXk2XTCNGx1bAXiM/ycmRVAu6s7//CI06GyNFNXdM2LyOIS1Yzn
	jUr1kOjuUnxD6z3Dy5jVnbvFtlH9gSCgTeq7tUB5RGSoKVMPcozJwJ5wPW+hNk+QsHjj09ZzgA2
	IhHTOjcRmYa1SAWAfYValno3YWyhnjEtXTf+BFUeMYcI3Y+mSFbUsQ1mSfKUKT+3mvglEoxIGs7
	OzpYCz9B3vQIa8E12yf7wcyhhEFXc/PrNtu0XB+ZysSNBH/2X5cbi7bs1cyGz3dRRC+iFViGVgN
	eN5zi/QzP7IlZTzCCJ1ao5ajiVSA4+LPELE9o2HOcV/TacLrWqxvEuUfK+/qwC8OPsIJmjzDjMH
	2KXU29QQb9jrX4eVPSfYuQ2yDXav+E9QslxkDRAtBWfc7RGMwNgUEPSQbAJwT32yrBwugAImyhk
	mhPeLAr0rE7XAr2A==
X-Received: by 2002:a05:7300:ed0b:b0:2b7:fdb6:ccc2 with SMTP id 5a478bee46e88-2be4dfcaf2dmr1321778eec.16.1772833173858;
        Fri, 06 Mar 2026 13:39:33 -0800 (PST)
X-Received: by 2002:a05:7300:ed0b:b0:2b7:fdb6:ccc2 with SMTP id 5a478bee46e88-2be4dfcaf2dmr1321770eec.16.1772833173322;
        Fri, 06 Mar 2026 13:39:33 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94823esm2232796eec.20.2026.03.06.13.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 13:39:32 -0800 (PST)
Message-ID: <beaed1d8-6c51-4aef-9fd7-00d9646db948@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 13:39:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] wifi: drop redundant USB device references
To: Johan Hovold <johan@kernel.org>, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hy?=
 =?UTF-8?Q?gensen?= <toke@toke.dk>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Hin-Tak Leung <hintak.leung@gmail.com>,
        Jes Sorensen
 <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260306085144.12064-1-johan@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260306085144.12064-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=N8ok1m9B c=1 sm=1 tr=0 ts=69ab4996 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=0Zwkj1O83uEaq0GU0uIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIwNCBTYWx0ZWRfX3mp3pKIYYdd7
 IK06P0zqj3nDM1r0V6Qk0r4voGREGVEXxtmagWscm9SMGSgxkcs1DQaJLape2TMne2H8c/8VKbP
 VsQg/5XgFqQcnCvxkeEnGQANra5R51VYbq0oA1bKC25uPxIZH2OumeRkB2xwoSIn+PZs36v3iVy
 nsN9mE03CKVbQx4UqHb4JJzgBJpexcejizLyu+10ajl7p+cJ4jtjqRpPm2ocgUWlXMycT1N/FjX
 082PNXieeSaE88StNHNs4Yc74Xnnf46VLYcOcI5+hwYdlnxvtiNZdB4CbbN4/5mQsnT4s96jE5F
 muqSyLlamYd/y9q3wO2wlYqMSJHg2WhVg10kE0N6k4dF3ieAxiMVvJ2oqRjQi2IBbWmzdmkV0e1
 Thc+1dnQrMZDCnVAutMmbUxCWzGKJGIake/Vax7FLIRnIlBM+NTuKsJDYOVzR59I7M9Ypq1PAsj
 U86L0VBxWwKTm1P5XzA==
X-Proofpoint-GUID: 9Qijs2dpKq23659I_jogYPRe3KxDtl80
X-Proofpoint-ORIG-GUID: 9Qijs2dpKq23659I_jogYPRe3KxDtl80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603060204
X-Rspamd-Queue-Id: B16552280EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32662-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/2026 12:51 AM, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop redundant device references to reduce cargo culting, make it easier
> to spot drivers where an extra reference is needed, and reduce the risk
> of memory leaks when drivers fail to release them.
> 
> Note that I sent an ath9k patch separately here:
> 
> 	https://lore.kernel.org/all/20260305105803.17011-1-johan@kernel.org/
> 
> but I included it here in v2 for completeness.
> 
> Also note that Greg had already sent a fix for rtw88 which has been
> picked up by Ping-Ke, but who asked me to send a replacement. If an
> incremental patch is preferred I can instead send a follow up for that
> one later.
> 
> Johan
> 
> 
> Changes in v2:
>  - include ath9k, previously submitted separately
>  - include ath6kl and ath10k
>  - rename the ath6kl and ath10k disconnect callbacks
>  - fix a reference leak in rtw88 previously reported (and fixed
>    differently) by Greg
> 
> 
> Johan Hovold (18):
>   wifi: ath6kl: drop redundant device reference
>   wifi: ath6kl: rename disconnect callback
>   wifi: ath9k: drop redundant device reference
>   wifi: ath10k: drop redundant device reference
>   wifi: ath10k: rename disconnect callback
>   wifi: at76c50x: drop redundant device reference
>   wifi: libertas: drop redundant device reference
>   wifi: libertas_tf: drop redundant device reference
>   wifi: mwifiex: drop redundant device reference
>   wifi: mt76: drop redundant device reference
>   wifi: mt76x0u: drop redundant device reference
>   wifi: mt76x2u: drop redundant device reference
>   wifi: mt76: mt792xu: drop redundant device reference
>   wifi: mt7601u: drop redundant device reference
>   wifi: rt2x00: drop redundant device reference
>   wifi: rtl818x: drop redundant device reference
>   wifi: rtl8xxxu: drop redundant device reference
>   wifi: rtw88: fix device leak on probe failure
> 
>  drivers/net/wireless/ath/ath10k/usb.c            |  8 ++------
>  drivers/net/wireless/ath/ath6kl/usb.c            | 16 ++++------------
>  drivers/net/wireless/ath/ath9k/hif_usb.c         |  4 ----
>  drivers/net/wireless/atmel/at76c50x-usb.c        | 12 ++++--------
>  drivers/net/wireless/marvell/libertas/if_usb.c   |  3 ---
>  .../net/wireless/marvell/libertas_tf/if_usb.c    |  2 --
>  drivers/net/wireless/marvell/mwifiex/usb.c       |  4 ----
>  drivers/net/wireless/mediatek/mt76/mt7615/usb.c  |  3 ---
>  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c  |  3 ---
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c  |  4 ----
>  drivers/net/wireless/mediatek/mt76/mt7921/usb.c  |  2 --
>  drivers/net/wireless/mediatek/mt76/mt7925/usb.c  |  2 --
>  drivers/net/wireless/mediatek/mt76/mt792x_usb.c  |  1 -
>  drivers/net/wireless/mediatek/mt7601u/usb.c      |  3 ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c   | 12 +-----------
>  .../net/wireless/realtek/rtl818x/rtl8187/dev.c   |  4 ----
>  drivers/net/wireless/realtek/rtl8xxxu/core.c     | 11 +++--------
>  drivers/net/wireless/realtek/rtw88/usb.c         |  3 +--
>  18 files changed, 15 insertions(+), 82 deletions(-)
> 

Johannes, will you be taking the entire series via wireless-next?

Or should the individual wireless driver maintainers take their patches
through their individual trees? I'm OK either way.

/jeff

