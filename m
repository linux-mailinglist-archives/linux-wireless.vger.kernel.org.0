Return-Path: <linux-wireless+bounces-18919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AACA3427D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451EF7A325C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D623A9B8;
	Thu, 13 Feb 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+hCG0Aq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141C22154E;
	Thu, 13 Feb 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457395; cv=none; b=TeZJDfThHVMc+qATS3775Uue3if41X/ykK7Y51YuNn+LRi+JpEQaqYyKUFi4eLVGoKKA91pSLSFMsoxg2nlzP5xnuf60egPFobD78eDmfPgSYdgTCrQvfEKEpJf+avyODdNdIzG/Ae0uSOSLm0GY5fsnLHQXriaf4io/xb83uLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457395; c=relaxed/simple;
	bh=9E38dq9mGR1MYPwVS38VQSpnRQAMRh37n1Six6KCqa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi1g2sI+p6WL0mfUpn8yCbPgXjKVYHnnEdYRGThQbwXhJa+QtI23Oj+c6x5P2mXKjmRTzcuG5cm4FEkmeLvOE9rm2ODol68Eike5JysllomtcaX6Gw1E1otsBDrxG+XxvqXn2VeS6LBIaskP07CaBU8UjqSPB+kktvabWhq6RPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+hCG0Aq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e83d65e5so2581725ad.1;
        Thu, 13 Feb 2025 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739457393; x=1740062193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUHLay+y48anjs7ExKk+CakAJpazy6tSeUYS+Xwbn7I=;
        b=I+hCG0AqYJSJMhZaBvxLd0TkmNDkIqdHx86SDUrcLl8HdIa4+6VFsBTFKkGONMp7Hs
         jDKz/0jZSYo/v81Gg3wKVekUnCbWoFdhbK3CzbdlIa+e60s92H10YdmJZqXEtfXtv8l8
         9FTPIoBgwfVCytEmB94oI4UYPq07qywW9TcxNk6j8kChZ+SDEQLOjPxhdzX8/WH0rOCg
         lh8WOotf1X+JQ/fVGGdZ4heu6dWzbGYWRUEye2r0hmJljX07/JTkyRAEd925rTC+oPEC
         9fJVu7EwlyKIAH6YZdgFqtd6DU4lsxz3w/SbHl+of37c0m0oWsKi9x+zrCJukFrPmU0n
         B9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457393; x=1740062193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUHLay+y48anjs7ExKk+CakAJpazy6tSeUYS+Xwbn7I=;
        b=neVFBc/ESMx0mLpOXuTO017dqkA/LyHnT25XuR3x/lJveksc0l3CZHYHKUsBCwdGt7
         QbzKGnhjNLbQ8kv7Q8kW7p2XtRo6ZN8d9m7LOjATPMsiJcqf7PoawqWm+COG/g82Xk/5
         th0Z2TQjftTK43jBnrSbKkngq0zETNq4d/g4dIw03AhLxHz0hVG+f5xIm8d+Mz9RP88M
         uU70/fEC562fdpeEmvcY/8k2TcGe4T08jcI2xH6PpvUkpiF/idge8RYVqeagAB0yDEAd
         yHVaKKAxaSaNxJEGKr8bHB3kYd81vFsIAskOrR4skXoKrRtYTIfD0kZ1n0QBVSGS8DLj
         KElw==
X-Forwarded-Encrypted: i=1; AJvYcCUO6S1gMqid65jrDHbDS511A9ZgyunZiS5H0XH1q2Mvf790KVk1z+el/SCKrjvcEkF3YKfO/B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG0EqmEpNTUZvK0JYKfk9KuJBwBE8QNBzgXU9lS9zSapqkYgV
	WLWGDU4snTlyz4Zcle3k8ObLgC06u08M5SdSHWOtDiWlT/68El8nCNXQz7IQ
X-Gm-Gg: ASbGncumN4ssdq4kb5/SOdg1p+EKGjshyTL3lbRY1Wlvjag/EzldPRbPdujgW+hrEtb
	/fvYNu+SzWtZxZA0RfLGri7vDfQjGzhkfbhIuxIAzhoG3GYxOGzMzD/pUGXgMkj5szyh7kl/k4z
	s4TON8h7A+Ph2so/tCjEloCUC2iLIhEA2xbOTBpFsSwov8Dzb9+2XMH5fe4wLgxlNPXK4k6vXrr
	aLsjDSomVE/JUGVLCc471L81yq/Ly8lh56IllkNpOsQVUpzVlcBTRsAmiYQCIYcZObIzTP7c3Da
	W246Z6vrpFmHQr8zt5AWzkNUFP3AYFNSNdVIHx/ZebQC1iq56rqV287bTTXz8N2JvA==
X-Google-Smtp-Source: AGHT+IHF3keZm+rb3LzCteXeeX4A5FDH1raI65VRKbJbOHB5Csv/B4vuTeBLTUnj78FyDPgas6dRDQ==
X-Received: by 2002:a05:6a00:194b:b0:730:937f:e823 with SMTP id d2e1a72fcca58-7322c443706mr11701063b3a.24.1739457392932;
        Thu, 13 Feb 2025 06:36:32 -0800 (PST)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-adb5a92d37asm1256690a12.72.2025.02.13.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:36:32 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	stable@vger.kernel.org,
	zenmchen@gmail.com
Subject: RE: [PATCH v6.12] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Thu, 13 Feb 2025 22:36:29 +0800
Message-ID: <20250213143629.3249-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025021330-squatting-routing-4279@gregkh>
References: <2025021330-squatting-routing-4279@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > It also needs to go to 6.13.y too, right?  Please provide backports for
> > > both as we can not take them only for older kernels as you would have a
> > > regression when upgrading.
> >
> > Hi Greg,
> >
> > Thanks for reminding! The patch for kernel 6.13 is here:
> > https://lore.kernel.org/stable/20250211130432.1091-1-zenmchen@gmail.com/T/#u
> >
> > Tested with RTL8852BE on Arch Linux (kernel version: 6.13.2-arch1-1)
> > and it did fix the issue.
> 
> Ok, thanks, but can you now resend the 6.12.y version?

I resent the patch for kernel 6.12.y, please tell me if I did it incorrectly, thanks.

https://lore.kernel.org/stable/20250213142946.3111-1-zenmchen@gmail.com/T/#u


