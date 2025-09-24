Return-Path: <linux-wireless+bounces-27628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CBBB981B2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 04:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA3E3AC4AC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 02:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E637222582;
	Wed, 24 Sep 2025 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF+TmbRz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F978C9C
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682783; cv=none; b=r4jzkkOCUgQRJP8HqdB9R9hFqdDNCnAfU7NljfDXKOBnbDbIKbWobLD4nd/HHkzuVaLVYD0hz9V6PzvwRJgNTed2nu9QGH1nQy2yGOw9rgMa/UOZ/4TTKPdqcnUXMVmfrKXCwMp3fNi75hpj0UKtueM9912otfusYPSfOoCYut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682783; c=relaxed/simple;
	bh=K0LCRCl86/E+hbnMzqJRccdVEjWIG0h84oyt/QPKKnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPuVfvmGny83EguWVcvvF0cpfNS8SIXOrpOVnmuKZqWlh6y33WXqJipRDQ5zIgKNhC/SFlA3+awNEeSsjWfA2VN2ZesAZeXQlvDXsXzjbH0dkWYb9NHaHNGUffSxHLah4xxQ6exVZnC92fD9ebVdSQ7DDtGed2bZ5eD30EoOTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF+TmbRz; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea5c06bd2b2so6499545276.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 19:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758682781; x=1759287581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K0LCRCl86/E+hbnMzqJRccdVEjWIG0h84oyt/QPKKnY=;
        b=iF+TmbRzeBni75Gm9e4zS40ozy4GXdtFvIq+G++kY3rIlmu5wkNCksKTQxYFmC1VcA
         bq5iCnj0klPO2FDKONzZKgIoiV1YpEc46aJC6C2p5iYH0U3FXS1W+moOzh7stmXQ+OhL
         y8ztg1eWSFA+0cnkC9J/sClyUqg+mSWcYUiPX9LTdGVNx+IXfIQHTI3JrGaMiEJ5NlDO
         ZFpsc8St3tG6gR9EqFYZektsknA3xFVbxrtvvdjLMxf8LMaWbY6WHEwVGSKv2prtMLPu
         Q+/q4+OxQAtH19yeIOmtUamRerlSY7xJShYZbFgq9aMSVbMa+QmTcbGmxETgTv+vOXGs
         n80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758682781; x=1759287581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0LCRCl86/E+hbnMzqJRccdVEjWIG0h84oyt/QPKKnY=;
        b=H+GHV3/Cm7RCRRt0eneM5lP8aUThXWWTxsnN8iu6glbLJLq1HyQly0cF0TkMGcRgNT
         ejHdf9hqdEKLkgGDyewylVH2fpHjjIW7BQHFO1QggCzwwQAZggLBBxi2S3IHOeioY521
         KQAC7FDKPJfMBGSjr6+7tjFMQ5P8lGu5uoMQDhqnX/4uXYWoGEu2H1L7DhMnXUhMkDu+
         NgRFK/GCP1Vu/svNjyvNimK3Iy+6S65wjH0mipQ495TO5DumKVdiNfArxNZK5Q+TUWi4
         COiAFoB5wfso8weC2aj+QnZj94tUSr+36EzWjsAEKo9YW+jqtgeQ9jd0JkwQv07HgHXD
         +4og==
X-Gm-Message-State: AOJu0YyiwW/7vtM5WjrOCZ28OdFebEIuNGGNTLBgMfqt5CSGCR9zvc/D
	tbLBnqU753aqbH4rt75yX9/2OxoTWVubHpSdnKnkuiI5BZhQjgcEmTeh8LkHFExrJitdCKRLmxY
	Wh3+XWCt/VV4OmyxbM4/SLGi18vrU+y0=
X-Gm-Gg: ASbGncvWFsqb8iJUBgBJMlhdjWPcE4FdsujSyYRy536Bxo84yuuw/+2/m8R6wmDY3oI
	Vx+Nu9JNukxIp/j6SoctoY2s32eVeazOxArRn55/fe5UzhuQviqZ7nP1l3wvuqbRWppMEk9EgfY
	mS75pa39/n6X+gKDOvHpfe8/evnkr7aKUn6sV0l9K0tfhKHthWvbmGhfeDReQNUF7Bwnc3K1WIf
	sCxLw==
X-Google-Smtp-Source: AGHT+IGn9alfmVUHg4s/EOSBDcyVeO2o2b4luEq/9VzOv8PSl8c2p18Wc2e62ATf4njqxKj8/5WQBlx5CdWjoV5QOQI=
X-Received: by 2002:a05:690e:150d:b0:635:4ecc:fc21 with SMTP id
 956f58d0204a3-636046650e7mr4242077d50.41.1758682780546; Tue, 23 Sep 2025
 19:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE3HL_yv8t1Rkd+jLfQMkc3YrNONQp0pRFESV+v92ECf_+7Xjw@mail.gmail.com>
In-Reply-To: <CAE3HL_yv8t1Rkd+jLfQMkc3YrNONQp0pRFESV+v92ECf_+7Xjw@mail.gmail.com>
From: Hsien Chou <s311332@gmail.com>
Date: Wed, 24 Sep 2025 10:59:29 +0800
X-Gm-Features: AS18NWB8jHPnvcaCYS_yFLDa1ZG3B37swbIlzMYM-jKhhrBXrPRh4H2FVUfXz2U
Message-ID: <CAE3HL_yETM7LBD5nu3V3zzfR1fThbAzULA=+YJt2tPY6=769Bw@mail.gmail.com>
Subject: Re: brcmfmac: driver crash with iOS 18.6.1, potential DoS
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
	brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Arend and everyone on the mailing lists,

I'm reporting a driver crash in brcmfmac that can be triggered by an
iPhone with iOS 18.6.1 or newer. This issue allows a remote,
unauthenticated device to crash the Wi-Fi driver, leading to a denial
of service.

The full details, including complete crash logs and a step-by-step
reproduction guide, are available on the GitHub issue page:
https://github.com/raspberrypi/linux/issues/7033

For a quick reference, here are the key details:
* Affected devices: A Raspberry Pi running as a Wi-Fi access point.
* Trigger: An iPhone with iOS > 18.6.1 attempts to view the properties
of the Wi-Fi network.
* Root cause (based on preliminary analysis): The driver panics,
possibly due to a malformed or unexpected frame.

Please let me know if you need any additional information to debug this issue.

Thank you for your time and attention.

Regards,

--
Ken Chou

