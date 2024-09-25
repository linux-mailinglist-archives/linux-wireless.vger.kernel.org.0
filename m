Return-Path: <linux-wireless+bounces-13143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F350C9854C9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 09:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D0B28131E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92B4158A26;
	Wed, 25 Sep 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhcoUzIE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12699158524
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251135; cv=none; b=QBvDldLGCxwAoKXErUKLSk3C9HypuP6jI7G+XTxT0KJs4uR/rv3ftw+wZ3wtB3r578CPnnzTDt7b638v7YP49OoxZESNvEFKSfwlB8W+dvIqRQdgO8/7czj4y+qvqrRad+SYbVKb7R8gYzqc7TyixKCCm9RoYTZi9If4fLh4vCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251135; c=relaxed/simple;
	bh=WVv6OSCm6xAgLTehSLVyHyFkXXNCv4npqcIwEXM8B5I=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=t+VheKmoQWipDAabyqrwDaq6zDy0ovQIvBsKAoLLhMW8Lf4AP2UCue+e198mMBVQuqMpvnqkxs/KoyuO8yTRzIurpEqm6R7qgP66/7g80ZZBiDIFj8y/QcSEdwsY5+N/U55tTSEEGREqkFbKga8Ga5q47/uUTa+HGm0yy3MYLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhcoUzIE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365c512b00so1090934e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727251131; x=1727855931; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3iCduWT2BS30CTZZwYYqqryBhTPqNFHM/UUFtN+9mQ=;
        b=nhcoUzIE9czA+k1Nv8fHteCz/RHVE40WGXY2u0BxthHVlEPuEoOw0eeGXd8pnraRAM
         gboVB3gDHMdEmrvRlBA5W6Fu6U/gBKKMsRx0AHO07oWWK4cV3MNDDuzferRNIRfOq+zG
         5Z5HLJA6plCB7ruzDrrgoqwxsJXJI9bygaXTf+15zhVCuH+kEhURYrnV9mD3HK8U4o3C
         wRUvqDb0hbgd4o5ohe/FPVoiXfWtxkf50oq9sTg5jxBsXz8JYgXtu1EykkV0LCW5t4GI
         rhPATBlSPz21eBrzeP+Z5LtfxBFO8VkQxraz/2y2CCpqipgJ0DJrnqnrWfsKW5uQkTZ3
         OlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251131; x=1727855931;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v3iCduWT2BS30CTZZwYYqqryBhTPqNFHM/UUFtN+9mQ=;
        b=pg/HyWPdeMgRgZ20dTvi2ohdJxLASrIRLtR3Yo1c3Klj7Tq/2RbZxE+b+52WHTS+8A
         ku4kkzIxzacuKu4/jcgtXhI4ewqtUb5g2gKxLnVTQQsanXREP+xeNMTUvYcAhyMvI5r6
         OpN0bCWsSSaqAa9seiDOkzrBOSOXP+q4pe7UQgebji4clHnFOkBy3iJR7a6BokxCLDyh
         CjedY82VVuujpx0CepFGlLvTpe0xDNZ9mDSxe7NbLKYyiXNlBW1l8uysBkPuNbOTu/xn
         LmzReevf77dCmRXr/3lhsJuG43TuNjYp8lVId07iLQrZeVYuK6ilSTXDAr4PfABJWCwl
         1rKA==
X-Gm-Message-State: AOJu0YwaNp7tvJrmR0VuxL8ezPj1+sinnGtuDxHb6x4JzUZwepffpT1a
	ym5UPboEDrlm6tUXodQgZqQtUTUnV8COf4eJ1d5JBcr99ZeuBAW7tzeCexPBmS8=
X-Google-Smtp-Source: AGHT+IEk3CHWevW2nNCEQ+zVv0leE/1y4CQr9+s/1m79exo7n8iC9IOXrT+gP+M1jZWi3dJTZqnoVw==
X-Received: by 2002:a05:6512:6c6:b0:52e:74f5:d13 with SMTP id 2adb3069b0e04-5387754dc58mr916824e87.30.1727251131201;
        Wed, 25 Sep 2024 00:58:51 -0700 (PDT)
Received: from [192.168.88.252] ([82.215.83.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8648ec3sm447475e87.232.2024.09.25.00.58.50
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 00:58:50 -0700 (PDT)
Message-ID: <4adb20cf-3a7b-4b6a-a9d2-92918d7ec4b4@gmail.com>
Date: Wed, 25 Sep 2024 12:58:49 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
From: Andrey Erokhin <language.lawyer@gmail.com>
Subject: cfg80211 and QoS mapping
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

IEEE Std 802.11-2012 8.4.2.97 says that if a non-AP STA could not find DHCP neither in the exceptions nor in DHCP ranges, it sets UP to 0

However, cfg80211_classify8021d has the following code

	if (qos_map) {
		unsigned int i, tmp_dscp = dscp >> 2;

		for (i = 0; i < qos_map->num_des; i++) {
			if (tmp_dscp == qos_map->dscp_exception[i].dscp) {
				ret = qos_map->dscp_exception[i].up;
				goto out;
			}
		}

		for (i = 0; i < 8; i++) {
			if (tmp_dscp >= qos_map->up[i].low &&
			    tmp_dscp <= qos_map->up[i].high) {
				ret = i;
				goto out;
			}
		}
	}

	/* The default mapping as defined Section 2.3 in RFC8325: The three
	 * Most Significant Bits (MSBs) of the DSCP are used as the
	 * corresponding L2 markings.
	 */
	ret = dscp >> 5;

As you can see, even in the presence of qos_map, it falls through to the default DSCP mapping, instead of assigning 0

Is this intended? If so, why?

