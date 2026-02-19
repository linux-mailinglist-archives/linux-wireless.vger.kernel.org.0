Return-Path: <linux-wireless+bounces-32007-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJZ4JqTUlmmVowIAu9opvQ
	(envelope-from <linux-wireless+bounces-32007-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:15:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269F15D3F8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7495301ABB6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16130BB98;
	Thu, 19 Feb 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSEQv8qD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93091284896
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771492514; cv=none; b=nxTuuVUXkrEC6+6l53p7AQUTdJLjJHVhM3epcs7UTmfSF5vIf4cdTj8LhkeVoDKBDuOWBQ1T0JJtcoOlnF+P8WMn1GezFFvYXJcKUA0cu7whiako2oFcrFxowytS2RHnSUySD1w2oHlbSeud3Ls+1pQzYT/5hFf8YLk2W2AniTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771492514; c=relaxed/simple;
	bh=gAGv+ewTaN7M7/PhGKlWuZhZ2xdGXioKVzIjyOYUHQM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NkzGSneZvSk7/7tZ/Pi20ACWgfxJb//yVG49/0T9MBI79KwaT190d8phJXmWXMttNm1RQe4K+tqgTwxZsqeBo9/5iVOyHwB4aWQLASlRGb888FAAsM7YyxhIKi8gvZjzdG5AaYdeZlLquTOlB7WwIDrQcB7HsfG+V1nHQowp3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSEQv8qD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-480706554beso7922925e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771492510; x=1772097310; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+NuR9VGQucH3RE5LsdgI6IWd0WqBlDZWEmahtU6Wyw=;
        b=LSEQv8qDydkK9fTTfk8GqiD5cEuRcoRG1Ue/2jWKaPO5NkjwA7CmSxpiNBHidXtoET
         fO1By5lzmEWCsD4vTUvF7k5MZt6Vu3WDThrp9kxO6RJ3V/Dl1LRLkz9aucmXbQ/nSfTY
         XeR9Wx9K37Z209HW+HU9FxG8qBRNbqnLi/0ICCxCyljWVLscZeOZOnS1nRS+LN+OmSol
         OEDbs2esVOtRh5GQ1KQRVHc99qhjg1OPemecuv9rxUWZ1NEDv6XUnMFSIp9Gqf3Vo4lr
         2X8kBz6LdTZcGpyTcujbsU/94E3UEc/pwfw9NUYPR8BosExJWSaKv2xUKmT/Y0tXyqDY
         Z4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771492510; x=1772097310;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+NuR9VGQucH3RE5LsdgI6IWd0WqBlDZWEmahtU6Wyw=;
        b=TVYEUV3FV0eOHXNZSQcq61TiJqmXatsobAH8vmF4nV9IJ2BTcTmirY4HPS3tkAPmzZ
         fMc+duj5enMLjcXWohdyo2yzBk0mo9lmLCJ+ShyYz4wVmn6fZZjfSJsDCKWOdJe/YArQ
         55cQGBjJRC59m9ejDzHuKAsjduDWnNI7fSmRf/Px+hpE68FC6eDvGBsaqW9iYSvAZRyt
         +zcVoYhuIrrdXBI/hggMwFf/K8Wzd2NpD/uE2FMbdd9xyzLaBMM19RWN8W9oTepalf9H
         setzzZ9StkfDOOPOCRtuclCwiMMgW7/vr3Ib7j0SVN978xrU5Mm5m3UEeSFNExcKubGD
         vy1g==
X-Gm-Message-State: AOJu0Ywhy9kUy9UMlupN6aMoRu+Ceu6yWD7642hwE4t0hVrGXzufVJgy
	8/6WEbLjMAUWpGmp67RozpBb4eZXyKIK6eBHNdgJVIhW/MHsAqkT7i7F
X-Gm-Gg: AZuq6aKwf/6hFEmZrNV5XkR4m9CtTOET78Q8yn9DguRTaPY8b3tXENxoH0vWnIVGpNB
	aBCnNBy28X9NTHE1CY19iaKOG/gV28XtX1Bou8+QwBTjt2eW7DJEEc/FH6IopAGs47PHGy1I2QN
	U3XJNmA/mrX5O1V93g2MXsdJFXSPr/3NZoCRBM93rj0j4GXxBSi1ki/dNn5IZIN5yC7fXdQ23/Y
	/Jltb90rsb44dcdcr/WUQryIeof5fZT7TyDfzJGekqG7i+aZnApYgujaOlwOObKJ1FnOoqteUVR
	HHw6EPDOSWh5eor6DWItnEpv7jAMeQW0IVpqG0wCvCSyvfJj0lv3HbGtYXQJ9kTE8t8afWU3qRB
	Lk0ukC32fC5gZcI3MKNKrjNde1LThjHDn965rSYjSmpohu75QGsy3FcT7JVEM+Cmirt48UdA2kR
	Er0DqeNQpO7zej+4Y2GgEaThgYn/JNWMawZ9OZSzIeOw==
X-Received: by 2002:a05:600c:8b61:b0:480:1b65:b744 with SMTP id 5b1f17b1804b1-48379bf7907mr264060185e9.28.1771492509311;
        Thu, 19 Feb 2026 01:15:09 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483801ff9b3sm362588785e9.13.2026.02.19.01.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 01:15:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Feb 2026 10:15:08 +0100
Message-Id: <DGITONL8L200.PJE38TDXYRQC@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Aishwarya R"
 <aishwarya.r@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature
 reporting
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Maharaja Kennadyrajan" <maharaja.kennadyrajan@oss.qualcomm.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
In-Reply-To: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32007-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3269F15D3F8
X-Rspamd-Action: no action

On Thu Feb 19, 2026 at 8:34 AM CET, Maharaja Kennadyrajan wrote:
> Add initial thermal support by wiring up a per-radio (pdev) hwmon tempera=
ture
> sensor backed by the existing WMI pdev temperature command and event.
> When userspace reads the sysfs file temp1_input, the driver sends
> WMI_PDEV_GET_TEMPERATURE_CMDID (tag WMI_TAG_PDEV_GET_TEMPERATURE_CMD) and=
 waits
> for the corresponding WMI_PDEV_TEMPERATURE_EVENTID
> (tag WMI_TAG_PDEV_TEMPERATURE_EVENT) to get the temperature and pdev_id.
>
> Export the reported value in millidegrees Celsius as required by hwmon.
> The temperature reported is per-radio (pdev). In a multi-radio wiphy unde=
r a
> single phy, a separate hwmon device is created for each radio.
>
> Sample command and output:
> $ cat /sys/devices/pci0000:00/.../ieee80211/phyX/hwmonY/temp1_input
> $ 50000
>
Hello,

In ath10k & ath11k you guys also had the throtling feature. Do you guys pla=
n to
add this also at some point ?

[...]

> --- a/drivers/net/wireless/ath/ath12k/Makefile
> +++ b/drivers/net/wireless/ath/ath12k/Makefile
> @@ -32,6 +32,7 @@ ath12k-$(CONFIG_ATH12K_TRACING) +=3D trace.o
>  ath12k-$(CONFIG_PM) +=3D wow.o
>  ath12k-$(CONFIG_ATH12K_COREDUMP) +=3D coredump.o
>  ath12k-$(CONFIG_NL80211_TESTMODE) +=3D testmode.o
> +ath12k-$(CONFIG_THERMAL) +=3D thermal.o
>

I may be wrong but I do not see Kconfig changes that allows to actually bui=
ld
the new files. Is this intended ?
 =20
>  # for tracing framework to find trace.h
>  CFLAGS_trace.o :=3D -I$(src)
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireles=
s/ath/ath12k/core.c

