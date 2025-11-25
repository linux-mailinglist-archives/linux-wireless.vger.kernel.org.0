Return-Path: <linux-wireless+bounces-29300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51281C8318D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD37B3AF0F1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 02:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87491E0DD8;
	Tue, 25 Nov 2025 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ejpGSCoY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JDOClAWk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50531A08AF
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764037710; cv=none; b=GnZScFKZ9cgLUnc/DXripZWzG/slFoUxCxaf2XN/25naCUwCOyu1xSmufpu3eGYP+b8R+EH/sMy/SZfkcPutqlOwFOSFvcP6oWxEbaflhiOe+dIXrvJHlus5nFhs29q53gLYA2O3cdXjQlYFOU+t83x0Lv62aUsD41VBjGjMXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764037710; c=relaxed/simple;
	bh=/O9XUyeCXZ18pkzxO79C3rQA/m3Jh2hww15iVKeiIpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2YivWp+V4w7NRJveTEs2bq0YI/gCrYy7qCrR9bxznd1KOyd6JltYMebWx0e2azxFqf95OUoqcwkyOnT9/NQKtCbCcMGGvHHNikZQ7H9fOJOWExR4ipVhZb83hIrftzkxKqQm46L5BCcIuU0psoLKGAJrgrRSOYft3zloYcNDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ejpGSCoY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JDOClAWk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOJru6R853004
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 02:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rFdWkq7N1RePZ6lwSsd6umoHDAVLFcodQErTRhz0ZLw=; b=ejpGSCoYOo4UfkTX
	EryBd9HxLb4qZmpPnRT7eSOVGx6kG3dBPBADuUa0SJysUNEphfk/vdWl6Uvz9hol
	JN2Z4lAVIPrAn2J21gjsMK98IFX+u2EphtTqOHJ2WbVEymPGN/lUJGZ/LTqKtenK
	lCb5zAJGw+U6bVIiA0Uj53xvbPlNx8soK+ethhR7s9kUEgXiNwB4GW1CqpRmcATC
	jbJRxmMwyYQ+FR2ot7Y3pLcQ4N1c7GMFutz54+sWvmhHFMnckLKSwdkZ5aJzu/19
	O+k28Ol7HHWRILr47Hu9MhY+0zAnbRU7s06yiMp1o2O+w8Ou9N2pXUNX5Ry0Ivli
	8ofzRA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amp56aanu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 02:28:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297e5a18652so55579415ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 18:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764037707; x=1764642507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFdWkq7N1RePZ6lwSsd6umoHDAVLFcodQErTRhz0ZLw=;
        b=JDOClAWkTBXTSNBmsOKTsbgeN0Q0OMF0Ax557+k/WHdmKfxOF+P5yMmtucGE4NSemT
         Ji8BgNxCC0+giLXBmiUlAGB7AZoO8tYYKM+i99Sgj4peSqc+0/TdsnMUbEwY/l6/YtDb
         djbogVNEeDVKqefw08Re9bMJGPsx699ODSIn15HeypjP856NvBu8SiED6V+Cm9jpqq4Z
         i8JmiMRyVcvzCeNKFLplbn/9fiZro8wQgQeyh6QYt/MFbCnNg8s2si28MquGbPNNqsaV
         +VoMlZK9JfOgAFIYnsJv7GehbikhGI0CPHrXs602eOa9fFgNURCpyIwQKSlT1cO44RK1
         hioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764037707; x=1764642507;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFdWkq7N1RePZ6lwSsd6umoHDAVLFcodQErTRhz0ZLw=;
        b=drpX2R0D8NtWJAI1sGeNIZN+tDoiqEOKJ3yczniVqTWZkx5grTAZx5GiAMD6+OTbnB
         PXoBwkGTuPT2is6nvJpg8+RjHNgXPZlqcBWb03jp8MWuDvPqvaqXSB7cROavtef9gGGT
         vFwToLIh+zYO8BdtVjhmYzOZlNQ74YD5VA4tbONnJxHZUSTRPrbbQdqZH7eJAG4iRprs
         dBjxKw2pkD6Cu0L5uYF++GtakaGECjkeBTR3nd27cjaZeqptAhqYDldBUKf0caTuwnIO
         Ar/Mz7rERB73r0tTawV06X6FMJpgN3oaq4LxqmFrOmwJjMAuTGgB4le9i5d8WQpo7kc/
         Kkdw==
X-Forwarded-Encrypted: i=1; AJvYcCU/9+jx8ZEgY3ncLRomqBpaIv1nbr2DFNicHdh3Rtnvo6QSt8kEVap5NXGK78951oKNKpfWb287+aPc5/hwnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySR8Y+u4biopfqyVIGsgyG94j1ru0i7h1NVvgGBtFPLyG0Nazi
	ekCaiZWr7t3sv36iwHJ/qm2mtMATihGoa7Gmrf7ptGpRT34d8XNcwYHypkINYyz+EUBSKoNXC63
	XpPn3l9w9PWpR/8mi39plKiBXBEKl3n4bCzMZRRfamqYhPL2dB4+SPYRkvDSMOTcc0tzRCg==
X-Gm-Gg: ASbGncso5P9ehRY9jiNb/O37eNkdQa8Y37SmhdoU3rG8FkPL3zur1livLyvckgq+V3V
	UFx16Pkp5GJsqBWFtAktjgtkhKTN4gn4/1nJXKa42EF8OnohLwG1GyNm5OWt/7wV06pfza1LOF+
	o2Y1QGVKTLJIt286ZDEyy0SWRxTdJ5Ok7Q5nX4UHpSb+w094SZxUmqljfm4CwwRz9F9uMoWAECq
	EI0bGgRp8s+043kDBv+5nw9Dtd7KrF/j7bL39r6LaVdNh+MoxUz1CVyvcZ42gbLVuG6Lgdzs+G5
	qnVvr3vaM+131OkrFiR7bZuzBeEeIGskvrFG4IfEh3jxVvkepTnX5Vuk9WG1qGThbr4SIpmnvLo
	tGeDVGlLJNEAb3zf8AzNSBc5AcJ1g3sXZ/EcuVPM04lpbZTmdpjljc7xOz+ptyD/LPJnr7wo=
X-Received: by 2002:a17:903:234f:b0:295:fbc7:d282 with SMTP id d9443c01a7336-29b6c508ac0mr173524355ad.27.1764037706889;
        Mon, 24 Nov 2025 18:28:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjBo6RVBZ5IwaETl5nIDAqZ2ejLZcrLB5pPI4JUiOaSHlNao9XT76E3M8BAUK8hMHqp2LcMQ==
X-Received: by 2002:a17:903:234f:b0:295:fbc7:d282 with SMTP id d9443c01a7336-29b6c508ac0mr173523895ad.27.1764037706293;
        Mon, 24 Nov 2025 18:28:26 -0800 (PST)
Received: from [10.133.33.245] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ad64esm149737795ad.94.2025.11.24.18.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 18:28:26 -0800 (PST)
Message-ID: <2faa8f4e-cb30-4e91-87d2-853c90458b01@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 10:28:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
To: Takashi Iwai <tiwai@suse.de>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251124134713.5819-1-tiwai@suse.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251124134713.5819-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UajwrE4fzLSAPlq8J0tN_0QNhjAWWedD
X-Proofpoint-ORIG-GUID: UajwrE4fzLSAPlq8J0tN_0QNhjAWWedD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAxOSBTYWx0ZWRfX5KE+iO3ZjR11
 KUWhDD3dHaBfoJaw7DWCqHmmWFvW46hh5CZ6MhSLLmoppOO0V+Rjgaq4IJ3SAqQH7WGdkioJhef
 +l1m/OHyiFEKmJ+xkugcWULF4P/he8s2nyCn3V9mFWyVYz10khkOda/BFs1ufNcPIaM4wAOHHRB
 gd9ilF4tzdYr/pVoiDGBvsakQKsgCuS3+Fzd4okidAvr7EyrtVKGkadle8FwaoqX4b7bf5m6d6Q
 HVBxqpu7xpB+HcyOaaI9grgpCuH9pKZ5sTPku7365njsTsOrHi8QUyf0pJlHo7ZS8GGTDb2sh3g
 WDRgdeG+VQpPwq/hUjJJcExvd2dOPDdKGICJNwYoYvV3ISkUTVU9du9seVwl0AX995GEdhcSkkA
 AU8qOJ1wB3iqxDNgA8P7nLvpyLaIcQ==
X-Authority-Analysis: v=2.4 cv=dPWrWeZb c=1 sm=1 tr=0 ts=6925144b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
 a=QuBVaXi81INSSeWXjd8A:9 a=QEXdDO2ut3YA:10 a=QxBQvo9kKf0A:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250019



On 11/24/2025 9:47 PM, Takashi Iwai wrote:
> The recent kernels showed a regression wrt suspend/resume on Lenovo
> Thinkpad T14s Gen 3 AMD model; it fails to reconnect on resume after a
> long time sleep.  The only workaround was to unload/reload the driver

how long? and with a short suspend you don't see the issue?

> (or reboot).
> 
> It seems that this model also requires the similar quirk with
> ATH11K_PM_WOW which has been done for other Thinkpad models.

the quirk is to workaround the unexpected wakeup issue, which seems not the same with
yours. Hence not sure if this is the right fix.

> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1254181
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> I'm not sure whether this model has another DMI entry, so put Mark to
> Cc.
> 
> Also, I wonder which Thinkpad models are rather the ones that should
> *not* take the quirk.  Since mine is Gen 3 and I already see Gen 2
> entries, which else remaining...?
> 
> 
>  drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 812686173ac8..3aa78a39394b 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -924,6 +924,13 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
>  		},
>  	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* T14s G3 AMD */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21CR"),
> +		},
> +	},

so with the change, the issue is not seen after a __long__ suspend?

>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
>  		.matches = { /* T14 G4 AMD #1 */

Hmm, I am feeling that we need to dig more to root cause this issue. Can you please help
to collect verbose wpa_supplicant/iwd log and kernel log?

wpa_supplicant:
	cd /lib/systemd/system
	diff --git a/wpa_supplicant.service b/wpa_supplicant.service
	index d5c7ef8..69693d0 100644
	--- a/wpa_supplicant.service
	+++ b/wpa_supplicant.service
	@@ -5,7 +5,8 @@ Before=network.target
	 [Service]
	 Type=dbus
	 BusName=fi.epitest.hostap.WPASupplicant
	-ExecStart=/sbin/wpa_supplicant -u -s -O /run/wpa_supplicant
	+ExecStart=/sbin/wpa_supplicant -u -s -t -f/var/log/wpa_supplicant.log -dd -O
/run/wpa_supplicant


IWD:
simply add '-d' option when starting it. You may directly add it to the systemd service
entry if you like. See

https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html

