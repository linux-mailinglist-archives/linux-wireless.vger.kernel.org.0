Return-Path: <linux-wireless+bounces-34205-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG1wJSpXy2leGgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34205-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 07:10:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A3364023
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 07:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFF7302F273
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 05:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA91122156C;
	Tue, 31 Mar 2026 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QEp2dXwz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gxi/qiMM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038D36C580
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933758; cv=none; b=tbV5oxSHwajTxNoe5sN7+F7RGdDL+qxWDzKHXtUlfwAGv1WKa8JF6gativqybt06ja+WM7Lx1Wfwq/V3dGBvkymc46H4JkCdkKFO6iqgbtYfUIv0LB3BEeZXRFKcp0d7d0lHG5hbZTsgL/Bt6mibpFZa7gjsrimyBISMdIfnDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933758; c=relaxed/simple;
	bh=0pJq4MlDMdNOwX9A6pV82UpuqP1Ji2CtUMg+r7hU2RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkKUCiAr4DV6/UfX2WtktQfUlCUQ408vJSd/mOL5e+ywTcuYQ35xX2ODlChA5fejaQ4cMtkm6DlniFf+rfbv9a7mq+AmxDJRgvvzrjXDRqusoXb2e47NgDt4WODUiK+MnUcf1jtT43xnpUrPLqwJOIVEbD4OuF6FeEfmMTePTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QEp2dXwz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gxi/qiMM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V16Zu81402826
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 05:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	31xwpGW3H5Whz8PFsjKKjlh0jWlzMoRYXFHnb54DDmU=; b=QEp2dXwz5F8spfvQ
	c2E2dQtp31YkIJnEucl2+Oc5pAvdh6LeciQ1pHrGRdLAP5bDT6S9fgwtXwD9994/
	sRAdrywyaIc6JsVwRAdAuEqC6WHp0Hzoh52DRiVZrVT2Yx2jQoKRdwQkguf+EQAS
	UpWPj74GqFQAY8/W6NNlRuVFR9YvKLXqvtXMrhtfAKeP5qgtLVW7KAN93WNn5BOt
	8138hvHVD+p8ZSyUHu1lnzk50b1KNV9GbwvzU4wjqn4NbJnEh+7wFolsyidy0XxR
	/Zh3FppVABlvNgKCgWgnuj2u4okvBiSHVcv9HxhshWhuWkvPpuYK+jCtG834BcST
	qyfelA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4hbpxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 05:09:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b0b0aae381so69474075ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 22:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774933755; x=1775538555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31xwpGW3H5Whz8PFsjKKjlh0jWlzMoRYXFHnb54DDmU=;
        b=Gxi/qiMMd6z/txdNgpeMsVESqJBVQ0dpnRE+mJA9mRCg5R2kt6g3K+pzuzV1LoseFW
         mmhcbSj7mdhJkNCo36+HVqCQh2vmwhPtHixqxOvi4mEod6ZlCI7ULxp2gsMKFhBu1YGM
         rovhXrVAHylusK1B3I/tUkBAtwWBLeplzTuNuLh9pdm18act83MdqCcdNVN+WpHUaSu+
         eVXuDintHr3xCLXyWR0xs52lrL3Hcumjf7kSfxYDSWkRnuLIiGhV07nOa3xVWru4gx+V
         fPz3PRzCqtcJ5RSCwDeoCl1nL/2OT2XKV/f3fTUUg1aq5Xyd84EBMZgYW27Q64ou76Q2
         mHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933755; x=1775538555;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31xwpGW3H5Whz8PFsjKKjlh0jWlzMoRYXFHnb54DDmU=;
        b=IAXe+NNvuD2A5aQ7Mxn5lVjvzCcBLqaoze3aL05X6mEwxeGPS8e9g2Qqc+9Zr53zKK
         riA5J5QFHNDtyQp2pHt7PkWh41jC4cOYQM0PEJZ6rk3kgKvx2lRGluZkxQitNDHF/jOe
         K3kQqRQnyuQafnmWNaBTGSCLYsu2Idz2TKOdTAlIkUDSbVtVS7TDYvGALTJ4H7yzR58n
         oDTew+javOQE+R4epDS/ZmIFv6E69hSog0Znz3fde51nlRfBUJDvmV0Xy77s3eDcyQWw
         ge+ReecMlP/G3vcA9phiTEa/O9wQUuO0PMaki2rj/uKdRPEIbVOitcGVj8/deZoTrZAC
         sZ+Q==
X-Gm-Message-State: AOJu0YzVfJZS0nYDWTCJBAjhX5H6EJSEGXa3SvZpxGTmkfEmDM8aYbOW
	3KarDh5wXVdAyspUO1vR4x7PtFzfuPIty1xelPG6yWlP3m0nnZ8U0O/xmMH0BvRECTb5/BTpKU6
	Ypg3/67k5IBWt5m4/Jl41vbc2D3i+AEuXjm47FF8Wywu5cPxegmljIBITHw1Kekx0IrAOeQ==
X-Gm-Gg: ATEYQzz9ViXRwZ15FjB2Iq068mODQJvXnc1cQrAQDL+TFtJfQrXfBBuP0a1qSuB8V6n
	yGedAgUhe9nEJb8Ii17ePDYgtQfkU83610MmrW07ehTHX0AQ3cVKLKK/jCJU6bPm2j2Vx1KtApq
	P0b6zjIOmR7J9OQ5izLZ4C1zB7WBRfEuiZzDn0XJo8Wa+qpkI9hILjYBwikn5HC22iYQpnLIlzy
	6JAB4O5PrEyFb5g9buCRuQC9OVy/ZRnyZm8L0nulET8E9rxwEWx4W76eZzqOlwwQLnAI3QeKCxe
	Ji3V5Ywhstn2tHmV4mDoixg5L1OslbuLcvdaAi8p9IGuga9G7dUTA+OCEFGHZ67/v2seRVpz3KJ
	JEWTaO4vMtfiNmI/sGHuzKi1XQ+3vyR4Z2jd4AFeEWozmf5hLwO5FYIElYrcjJJ1dBsD9okttWp
	TU0byqPBK4XQuTBYcwwA==
X-Received: by 2002:a17:902:ce8c:b0:2b0:a957:304 with SMTP id d9443c01a7336-2b0cdc22fc5mr161202545ad.6.1774933755380;
        Mon, 30 Mar 2026 22:09:15 -0700 (PDT)
X-Received: by 2002:a17:902:ce8c:b0:2b0:a957:304 with SMTP id d9443c01a7336-2b0cdc22fc5mr161202315ad.6.1774933754890;
        Mon, 30 Mar 2026 22:09:14 -0700 (PDT)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24265aa9fsm95009055ad.20.2026.03.30.22.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 22:09:14 -0700 (PDT)
Message-ID: <323b5222-a105-4701-8342-9131660fe803@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 13:09:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ath10k: skip quiet mode for WCN3990 to prevent
 firmware crash
To: Malte Schababerle <m.schababerle@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20260322124822.230492-1-m.schababerle@gmail.com>
 <20260322124822.230492-2-m.schababerle@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260322124822.230492-2-m.schababerle@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA0NSBTYWx0ZWRfX30FU9uydXKmM
 gHmO2wlaXzioqYme0LWAgKSjDJ8TWoHmo+GUSpli8aWo+i9slNT0oWHHBcRkhjX1tBw6wqXNtcM
 3vmjno74XyWkkx0NOVT7gWhr0aid/4itLr2vTXuirnN/CddCDW0qSLeIOsUXPY4Q+s/4x0xF21/
 mKiIQuBgjXN9HTsZShCAAHzdFjFcRWSXYtXzSrJOta9y8dwTnvf9dQIpOXZ+XcCDUOqoXMrPkIT
 C15xHgRwLNfFUoOBWlrIpNhiObWqrBcBQ4v/PUbfrBbrR8/tYo/yBis879DOwWqhRn+BIAt10WS
 1INxi7Ny5U0mkSvSx6Y6wpI3Eto9PiI3KYd0oaHuzvpsnZxhn3VPEeMDc9NccUjGUjr+nSQNHk6
 Ia4+LXGDBQCPtR/UlMDozaq+UwyTodDlwz/Cwbymhg2j2k2x4iUY9LYorSgSeXTy13ahQtZZ3KD
 xaaRW0lze8j9TZsEfBw==
X-Proofpoint-ORIG-GUID: cT3WEWdYiS4JB4C-vk9Fb8FBVSIKJWI5
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69cb56fc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=Nm7j3lLI2G_-0-y7RwkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: cT3WEWdYiS4JB4C-vk9Fb8FBVSIKJWI5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310045
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34205-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E31A3364023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/22/2026 8:48 PM, Malte Schababerle wrote:
> WCN3990 firmware (WLAN.HL.3.2) crashes deterministically when the
> quiet mode WMI command is sent during ath10k_start(). The crash occurs
> at PC=0xb0008e20 in wlanmdsp.mbn, ~17ms after the subsequent
> vdev_create command, and cascades into a full modem crash.
> 
> Commit 53884577fbcef ("ath10k: skip sending quiet mode cmd for
> WCN3990") addressed this for HL2.0 firmware by gating quiet mode on
> WMI_SERVICE_THERM_THROT. HL2.0 did not advertise the service bit, so
> the guard was effective. However, newer WCN3990 firmware (HL3.2)
> erroneously advertises WMI_SERVICE_THERM_THROT via its TLV service
> map despite still being unable to handle the quiet mode command.
> 
> Skip quiet mode unconditionally for WCN3990 using QCA_REV_WCN3990()
> instead of relying on the service bit.
> 
> Tested on OnePlus 7T (SM8150/WCN3990) with WLAN.HL.3.2.0.c2-00006
> and WLAN.HL.3.2.0.c2-00011 (both crash without patch, both work with):
> - wlan0 comes up without crash
> - WiFi scanning works
> - NetworkManager recognizes the interface
> 
> Fixes: 53884577fbcef ("ath10k: skip sending quiet mode cmd for WCN3990")
> Signed-off-by: Malte Schababerle <m.schababerle@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/thermal.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/thermal.c b/drivers/net/wireless/ath/ath10k/thermal.c
> index 8b15ec07b1071..33f299f414710 100644
> --- a/drivers/net/wireless/ath/ath10k/thermal.c
> +++ b/drivers/net/wireless/ath/ath10k/thermal.c
> @@ -136,6 +136,16 @@ void ath10k_thermal_set_throttling(struct ath10k *ar)
>  	if (!ar->wmi.ops->gen_pdev_set_quiet_mode)
>  		return;
>  
> +	/* WCN3990 firmware crashes on quiet mode despite advertising support.
> +	 * See also commit 53884577fbcef ("ath10k: skip sending quiet mode
> +	 * cmd for WCN3990").
> +	 */
> +	if (QCA_REV_WCN3990(ar)) {
> +		ath10k_dbg(ar, ATH10K_DBG_BOOT,
> +			   "skip quiet mode for WCN3990 (known crash trigger)\n");
> +		return;
> +	}
> +
>  	if (ar->state != ATH10K_STATE_ON)
>  		return;
>  

Malte, the firmware team needs firmware dump to understand this issue, would you be able
to help collect it?


