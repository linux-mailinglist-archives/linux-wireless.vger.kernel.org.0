Return-Path: <linux-wireless+bounces-80-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204597F8F83
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 22:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB2E281406
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF379442;
	Sat, 25 Nov 2023 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9+kZQvC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABFE102
	for <linux-wireless@vger.kernel.org>; Sat, 25 Nov 2023 13:36:09 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9fa2714e828so413453066b.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Nov 2023 13:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700948168; x=1701552968; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZHRljuRTF6BeP4apB9A4iFgLrMstOThUDWEk81+JuA=;
        b=a9+kZQvC6298tn+Xx9vEOtL1yuMTK2DnIb47ZCak+7y/ngqBgG7Wk7x4ewDYubZlqf
         ZxnehjbYtfpIdzZhQFmgMubGA/AtUL6LYVoHqRi+CCuRNJJitk5sjBd4R45B6yoL2Zet
         cW/SPhP6fel6rg6+CEMsfp5WYUNnRt7tGYPsoLc36eF4HA1E0NqBucaGjxDEOFylSD0T
         BjazOBuIw66ESRTL9MjLxHZj9AUjzJ/y8KK1x1K6qPmgIfzJJgVvkfQ3T3ryu1Yv360R
         CGWOidmQYCkdIvulmqMdvpOvBIhoduJxnk4WdIp7StLd0v3/aJShKej8cnKHlAbnGbWr
         KYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700948168; x=1701552968;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZHRljuRTF6BeP4apB9A4iFgLrMstOThUDWEk81+JuA=;
        b=oA5GUcjuI1K4id7amRRoW848IQxxErBz2yv3kK2l08JL8ZZsNgbhfno+2x8BmogXrN
         VKbga2F30HlqK+rtNBuybYSht39c6o3PzoJ2wh/wt3o22OdWgur8RVjQJ98MIIZtb47v
         QO2DjxVHN6LnYf4xjwf7iAX3cnzb433eTUphTVH/A9UQxSz6HLdGtffR3P4ez5C6HT/A
         fQIP3E2sp2+hAKjkpuKDKl2q3bIcH75e8NHgFL+TmmyVPHXEfbE9LgbNgiZhM998E82w
         YzbtV/zN00WhvpDmyF8LgDIgOPXTYFVNu4O90Y1waASn36PZ0OcHpBr4buNiNjf0R0HC
         Tahw==
X-Gm-Message-State: AOJu0YzpENFUXv/UxZzVWl50WEBvJ9qSzYaluceb3WVT7/3qmtR2wWvg
	3JOKR5PpMz7BGheRaqkU2irzKgoRPV7I8p4CwVp/qmaA
X-Google-Smtp-Source: AGHT+IFv0lQRhbkS180VBHGsBk9UeBe3lHDUFvVseXAO78gDt8oKG43QKSg11CDLzVP7Qcr/Sa1I++zU53gwHBc8yG0=
X-Received: by 2002:a17:907:6d06:b0:9e5:2c72:9409 with SMTP id
 sa6-20020a1709076d0600b009e52c729409mr6694861ejc.43.1700948167641; Sat, 25
 Nov 2023 13:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
In-Reply-To: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
From: Ali Ghandour <gandour.ali@gmail.com>
Date: Sat, 25 Nov 2023 23:35:56 +0200
Message-ID: <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
Subject: Lenovo LOQ rtw_8852be
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Following below thread, rtw_8852be driver fails for Lenovo LOQ:
https://github.com/lwfinger/rtw89/issues/235

rtw89_8852be 0000:09:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5 (da87cccd), cmd
version 0, type 5
rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5 (da87cccd), cmd
version 0, type 3
rtw89_8852be 0000:09:00.0: MAC has already powered on
rtw89_8852be 0000:09:00.0: [ERR]pci config read 719
rtw89_8852be 0000:09:00.0: [ERR] pcie autok fail -22
rtw89_8852be 0000:09:00.0: failed to setup chip information
tw89_8852be: probe of 0000:09:00.0 failed with error -22

I am running Ubuntu 22.04.3 and kernel 6.2.0-37-generic.

Please advise.
Ali

