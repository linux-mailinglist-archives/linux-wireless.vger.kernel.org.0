Return-Path: <linux-wireless+bounces-38965-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y80MNG2vVGq1pQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38965-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:27:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB9E749464
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:27:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HdwIrk0r;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bUeOrOkR;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38965-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38965-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4174B3019178
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE4374731;
	Mon, 13 Jul 2026 09:27:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64F369D6E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:27:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934826; cv=none; b=DpylCRJaYyYtVr9eTEq8Jqe+hHyDF+7jrH3ZszsQ2glkQTunkjFzy7DWpDcS6Nu4kMfSok8PkDiSVRHZ40D9m8EebRi/fRm9dPeBsdUs4Gel1DYOea0hJNMwGe39tU68fpx3Io/zF1AfpIEt1ucAx7FtGjyMm6ypWBcmNyHiHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934826; c=relaxed/simple;
	bh=S6dHWTrRZ3r4ne4IjotTKbsr53JM3p8GHfKRLgt/YaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyCMuxiwxBNu95UAwJy/5lCQAq1Sv7E0j/UrPlhWolZl4/n6ed/x40bwvvPblYvX8QFPigLTLK6FT/ayDr1xgf1ZDgwA7udsYFd3Kye92Ba9b/3jCYahE+h6ABsa0kH3dDnaokqnH1SySovub4duRZur3qyIquKqscWFXqQ38i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdwIrk0r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bUeOrOkR; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7YpQ8794362
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z/u0inyOZn7nEYb4yu8mT0JlJ/zMQrN1avKrexZU9jU=; b=HdwIrk0rzlFLq30d
	juTfJw2MaWx8PMyWrnBcV5ZIXlAAf+aAb284LOlkIcQooQO53Uj/hlR+Bwanito5
	s22EpRNpGDTct49zYPps1IhxrTQ1AC/aBPxWuZHlEWqAHe9kVvhkAP7OoylKA6+m
	ugZvZ5M3y9wRYunEdfGVo2PKpULQzrQZopkU11B/kw9cxwiV8nLBsDbEB9X3A/XJ
	1A/reqeJgl28YzPgQUw5XAEM01aWmdIOc2U2mVeXNeaU/PH3DcXv3LQRNWzpi2Ud
	i7I2e39EJVZxYY2lMhrBbTGaCkP/V+9Jezif8+4L+efJzqAaVKOP61NaPUk6oNXr
	0AgIlA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcurn0dac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:27:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc640dfde3so39927795ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934822; x=1784539622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/u0inyOZn7nEYb4yu8mT0JlJ/zMQrN1avKrexZU9jU=;
        b=bUeOrOkRWQIstLHBNOrsicaiE7rltLUsR2w8AwAatl/mTsFnl1sRrbZebSVJbUH/HB
         hmlzGlHC1mAt/iBkYTgUZSDAPCuHJJEpUIt9SmySfPSU9JeOwk78aQ37T0mjpZPmFQyb
         AyLPj0+2r57XJ6hpXNZ6fVaqDP7tvF1NCGQ5fFf4ipxKAjJ1NnLfxc+GiD7+4ymQSMDY
         nn2CNJVqS5KEk57LzPPfA32icMFaoOR3MP9o5lpCE+tIQVAOeECRmS3DfT4mBzfLJwaQ
         ZXCZUW5PwHyqZ9m5BflQoLNyhtB3ecXA8GOXwq+WxARMdc5fPxzrWB/tsDwfjbZrm8O2
         FN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934822; x=1784539622;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/u0inyOZn7nEYb4yu8mT0JlJ/zMQrN1avKrexZU9jU=;
        b=Xo0upPFbRLyemhOGWCusqUpIpfdKgwdDQ6BwoYs5lKtYNGXsrO38qyGsvrs0VRM8CN
         uTQLPaacTcqVFkpATRQYYE1TPg1QWXn+/hfSO0m1KIpaAYgMuYBl4GxDqYdfE5Y/FXVP
         dhsqTCdEMfMWiJFsc11ncJPyVzcA3czERhDt6GtEITLPQdwiQxYuoPZdpL4bTyIXIzf0
         fyQ6MHOPnRC5WtjDHvCUixN47DBYoUBwq5ro4nUQU/U+eo9EnO1c+hQBgIcfKqZ1aJ06
         CHsIbGdr54x+b6/5k9Os7EXdzmMb5FxKNouS0OZKK8d+RaqpmMxGJ+zJoAB21TpWBRAi
         0WrA==
X-Gm-Message-State: AOJu0YxFYyyAJSyFLD2RXP+tOA7Xjc0Eam5S1EhxwOZmMBVMh1cSO+OJ
	1jDTBPY0jTr4uHUtFk8pvbOzgahU5Ep8/RCpGv6JgmQVR1YAYiJAzkuqzucTcmLlaSPE9mso3oU
	E/7BpHNb6SvuuThFR834BEkuUpMM9vnP384OmenzMV5v5dVtuHan7hLttNZwuep43bCN1w/DTYy
	wMcQ==
X-Gm-Gg: AfdE7ckBhxfSWrMZ1/n1axzyaQFMTDTjQSrerQwP2tV40CRWZVo1S6eMAQw2e1HCwM3
	eXhjD0oXXbzsGlMtnHjFZGVYLmu3fZBXPQXWuChp3gYKpANVz0aaX0TestXuAIJtnoHfjPCnL5x
	6OoTfaGc8q2MRcMci8oB1SRK8ivhiCkPSaOp2+97DYIbwQKFFnlua2wY+y67xg39cbPsN0IFrV1
	cM8u+AkvtR0neJDLEH2kBMf5qGccL0AZeerRcBZb/4RH2Sy5SpGDPq1pFLZs2a4VmJ6ApiHh4rU
	SHfxaUYNkKecQ+Krjc5Z5Lk+HjMiRpV74n7snRIGHKvb9a9oJh47NMfPJsKMOgGBg2DfCZPh9oM
	/8feQ7bjAu0rywFutRvwu1ekxwVY4lVcWwx58clZSAQhw6pSq09o=
X-Received: by 2002:a05:6a21:3a94:b0:3bf:63af:84c with SMTP id adf61e73a8af0-3c110a74037mr9284967637.41.1783934822541;
        Mon, 13 Jul 2026 02:27:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a94:b0:3bf:63af:84c with SMTP id adf61e73a8af0-3c110a74037mr9284945637.41.1783934822031;
        Mon, 13 Jul 2026 02:27:02 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313c50c70c9sm25094642eec.29.2026.07.13.02.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:27:01 -0700 (PDT)
Message-ID: <072a0eef-6b31-4bcd-9cbd-d1b9f9bc56d4@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:56:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ath-next] wifi: ath10k: trigger hardware recovery upon rx
 failures
To: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>,
        ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260710060406.3323260-1-manikanta.pubbisetty@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710060406.3323260-1-manikanta.pubbisetty@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8oIiylBljo4yjqO-VXUqfOMMzdCZALcY
X-Authority-Analysis: v=2.4 cv=IcK3n2qa c=1 sm=1 tr=0 ts=6a54af67 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=egApRZYCym5QJ-JG5DAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5NyBTYWx0ZWRfX3Ri1W7w9OUb5
 orLvgpgsGrBD7YWqKYQl9jglIiab0Kw006+3QMmFPfskfc4CvnNiA3hmW9nKTY8IHk6KHny8heD
 EW1B1/ukdr3WYXR0Q/TNHz7PT0bUKDE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5NyBTYWx0ZWRfX8qxlVawfbFH4
 Qy4hKoKigThXvXV54QxoQQzaaFXENzuuZxGQCvYS//AIIDO6yxxPQiTPjthQ3eB1j/i2RW1nHRp
 M+LBVdu4J7FK3R0qTOHWAT+OEE4uUoUK0CO7tK6zmZwTeVRndTep7GOfs8z1jyk9le0s92gMss0
 MiIILd/ehYRWTlPQVKOeW+sJ2iCFC7I1qwf7YCt24Vl36L1FI3plJCI6md1fuZEyADiNAtq58rN
 kKQkB09lejE5KczRII+GloJ5ngJ0mJzp8LbZStr3sYhU8Ufxi2J/Ps2y9LiMfb+qJgN3JbpBx68
 9mrZq+ygOg2T503/tkW1VOSWrt1G0I8bzRtd/1En88ctu52S1WkG8DH1J3pKQ77M3XIK3LPH1g4
 ywpmhaZmjdzhamLfz5dTfNX8+GxFe10kDVNiQwIlij2YuZGAFi++a+S3FsVitpUXdRLmTV8tFab
 o2wchTQ/6RiEnoO+eJg==
X-Proofpoint-GUID: 8oIiylBljo4yjqO-VXUqfOMMzdCZALcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130097
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38965-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:manikanta.pubbisetty@oss.qualcomm.com,m:ath10k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BB9E749464

On 7/10/2026 11:34 AM, Manikanta Pubbisetty wrote:


[PATCH ath-next] Prefix missing in subject

> When an error occurs during RX packet processing (e.g., MSDU done
> failure), the driver sets rx_confused and drops all subsequent RX
> packets until a Wi-Fi ON/OFF cycle clears the flag. This can leave
> the device in a bad state where it cannot process RX data traffic.
> 
> Instead of leaving the device in such a state, trigger hardware
> recovery so that such an error state can be reset and the device
> can function again normally.
> 
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189
> 
> Signed-off-by: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
Actual change looks fine,

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

