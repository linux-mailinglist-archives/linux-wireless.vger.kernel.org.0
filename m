Return-Path: <linux-wireless+bounces-4879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639A87F8F1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5A51F21B57
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7F77D3FD;
	Tue, 19 Mar 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brbDEzzs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E817D09A
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835687; cv=none; b=Z/3z7jhbzl8sWNRYO6HkuM6u7CBrBHwE0VeaTlD91pQQBh/fZrxXB586jHoppKLl6wkZA5nSKkt9g5WIQsE0rOOMEeAGbKwpqlpGvy93YPgDXaTyv40JdSFv6DNs/MHsFkC1iyaoGMSM6ku2OC4ahafpcjWAE7e5egR3mkdom5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835687; c=relaxed/simple;
	bh=k4erj6xVZIHayXhp/qegMqGx6hYyXsqQU6FKPG4262g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVDNAvs09mDIFxo9woNPmqU6+eGjyORSOC7CwqlbAnh78J3T0hRtj3XHW1kYkDh/563bPxJppYC9pAC31z9pRsfKJjW9oYM/7hlAFExPoqmEhx+bWc303q1FPBD09qKZIZdkFxCYxPQh4rjNc7oTkCQ4NTuDN1HH5BBCxYzL1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brbDEzzs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso3174420b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710835685; x=1711440485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivaz547VKBi72asZXh1fT5IjDDye3P24j8gXt2L+PMI=;
        b=brbDEzzsYoDRzXzkgkFblq5w1y21q536mlgCr0Zqo8XmVYMpgVpmRhRBoAFR/TQbge
         F5Dz0+gzdQGWTGgJgiRq2sO+k9KLRkUtdq87R7xAxQ2cMjnRTqPJ8pIqcu/sZSPblSx1
         yjV4nLhbODMRSLc0ajuhD2II5a+I85QJFIhuKdRbIQbl1hx9csY4/2z6E0VBvP6iqAt8
         mi+SxBgljQnt4l4K8R380VrTmoZ8xwHmt7v6xWI5HJBjCzgfg8AzQbf7yCcvflU8t/Ho
         HBj5tx3UCGbFIJuIe6A6nabAaw+SPNnYJdbrzO/NuK4RvfHyPU0hKWR69TxhEUepI/qo
         d1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710835685; x=1711440485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ivaz547VKBi72asZXh1fT5IjDDye3P24j8gXt2L+PMI=;
        b=O9UwsjRIfi4ZT5iTPfJs3jpMZWXtKVXfPNsQjFr+kU7th1qFXxWpJBX5f3ZEBUhKBV
         KLy+OGOtoSr++YQ7VdNJLQvLADvPwM8ZC93S0wbTxjnkf58XQpqHOpxZHiIdihifteM0
         +GiPm6T5SjplOk3XSe9hvtTJyK03FO3Z1/P/3VIadru7sls7UfBznWabuZ9STtgAmI77
         nBp8PuYQj4mPUd4GxDf0raC5CoZq6KbKq2HzUL61f0u8kBUL7wVU4a5I5NcxmFVTf5Pc
         d7/dhnsuXHgf3OviLWaZfheHz+Q02GacmoktEYYj5MYXOpEvJTOX20IQmSA1679H/u5X
         PUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXozTASXZ5lArtMJpcXq37u8bBhZfjTDD88ZPnuC7fcpXHPrnzmsles44hF9zf+ICuGHanCPuCG7lm2jHhcbqNAPlXTsrMggd+o9pCSPkM=
X-Gm-Message-State: AOJu0YwlQ0LjbiEj0gEN5btQxcSjbECNQ1rZ+l1i7RtZSwJHvspQv8cL
	rUzRo9/YVxsd98IzcT0ZBcr/neOI/xBc33Ptn7kuLAM767uEYhTT
X-Google-Smtp-Source: AGHT+IFS+a1Q/Yfisj2UqvDLGDg33gKHGdLdb46WTm70RopZCHOCvVPnf3vz3ha5/9IhIZcZxdx6Hg==
X-Received: by 2002:a05:6a20:914a:b0:1a3:71e3:80e2 with SMTP id x10-20020a056a20914a00b001a371e380e2mr2080228pzc.6.1710835684764;
        Tue, 19 Mar 2024 01:08:04 -0700 (PDT)
Received: from localhost.localdomain (1-170-103-29.dynamic-ip.hinet.net. [1.170.103.29])
        by smtp.googlemail.com with ESMTPSA id a17-20020a631a51000000b005d8b89bbf20sm8236057pgm.63.2024.03.19.01.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:08:04 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: rtl8821cerfe2@gmail.com
Cc: Larry.Finger@lwfinger.net,
	chewitt@libreelec.tv,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	s.l-h@gmx.de
Subject: [PATCH v2 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Date: Tue, 19 Mar 2024 16:08:00 +0800
Message-ID: <20240319080800.2994-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <68f0042c-675d-4919-b001-680c6b1c1cdf@gmail.com>
References: <68f0042c-675d-4919-b001-680c6b1c1cdf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for this nice work. Please consider adding support for 
D-Link DWA-151 rev A1 (VID=0x2001, PID=0x330c), thanks!

ref:
https://deviwiki.com/wiki/D-Link_DWA-151_rev_A1
https://techinfodepot.shoutwiki.com/wiki/D-Link_DWA-151_rev_A1


