Return-Path: <linux-wireless+bounces-10985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F79948721
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 03:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90654B22E62
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 01:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE309A94A;
	Tue,  6 Aug 2024 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3yET7Yz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC86AD51;
	Tue,  6 Aug 2024 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909557; cv=none; b=GPBtE1VHVcO7Se3zT4rzHZ6oXE9P4j4aHYucWwV0AqrmtLDdvAHL8quBKn5xc56V4YbpCSx7Jsnm+o1JdZQ8bc87P+D6sb7oXUNebPJeXSsc/g3Q0gkFaPOzEazpL/8aIpi911NaCk9BF8GFCwOb9/Pwb0JSWN+ujZpiQBRvyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909557; c=relaxed/simple;
	bh=457dMZYS6I1UY/RQefy4FDvm2BkQbI+4O/PlCAzmiOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fyJgVwTzWqmRndbx+6AgmwcTYuZZcBMptx5/Am15Ps7hITs7tvH45e9nLll+2ECabhUAAW/OOG+Dw/uEvjyNBHhEwj4J57o4ktFWT8f38t764XsUSNNraAVZoINnygSK2tGTwjvTKk/B9YqGs3OjVpHY+/xT68c/+rxlH0ot1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3yET7Yz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4fcbb131so540515ad.3;
        Mon, 05 Aug 2024 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722909556; x=1723514356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=457dMZYS6I1UY/RQefy4FDvm2BkQbI+4O/PlCAzmiOw=;
        b=J3yET7YzMxfYsO61dW9Wj6jtMny8nzzTgxSB3gAIzVkoU/GL6lKj5ivQXt2qw0vMui
         NDINYSAn1KevOwnOsMRQ3PzRSvO04hoWtBWveonyTWXQyOJH/Kj9SekXTWS996Q2hp4y
         CWmbQeZxyPzjLm6TRLj/70thZG2Gqze//BdyTL4Xqb+A9mZ3O9TeDQmKyaEZIsrW5700
         277UvtrhCw7QuQ24ue6tlOgagKvcpTFRX/rCAuGgN33R6XwNX8AwHkhi/S+q2TOzvYBM
         BTl4xi3XFY4KnzlBK8e6ocCRsrzBdOSM7hp2A9ily4ngj80UitoEJrDMAe3Cik4yVPD2
         DZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722909556; x=1723514356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=457dMZYS6I1UY/RQefy4FDvm2BkQbI+4O/PlCAzmiOw=;
        b=VwGC2Q190dvsBWz+OB7J2XeOef94swwGSLSwFlsG4RjqZorN2RbZ+GbnAvCbu3C9Xa
         TpXXpdsKyApkCFvr+hZlnBewlKJq6Kx2ypka3ITb+5rOiSFQOswEePdE01q0PTRIa5ho
         NgvpRVXISBeDj6v8M9/yRvuOlG3ie1leI1EG/xoMk2Dt1Ten7qI58Beql0PYF8/5LZzs
         getldod9EsAreENlJ9c9+jc98Vmr3/4pYn+2D1+1W+rXCt4uBOTZg3RCbYCqFuePfhL/
         r9uRT7N2asS6jZfq/ztmYCPQFfsYAinABRGY10VscG8+qXcmFeEfWwb0x8v2ZtBpX+7j
         +KFg==
X-Forwarded-Encrypted: i=1; AJvYcCWvJ/8zQ9AVBuMlO/A6/wy2K+eQxMWIH9jnA8V2AkF1MTHqRwXyEAn3NRNnZhQEv1DEXZIRXmRzvLTNz9L6ysqnw+aXvApbVI1YUY7p6FXTwlUlRn/5YKxr/lZndDWV8cpjUewun/E6DvNssiKfdX0319/yRGtOOO4YiQx48lTRwK5v1DNViAE=
X-Gm-Message-State: AOJu0YxBm93XJwOFYkLrs47zaA1sQrL2/6iFnFOf2vwE2WYUC7HYob3s
	88hdXLkpNPCo7wOIUOviD/GMXEfOftuDHKvdwh1q/7BGaSsVkPKSft2pw2DBUvrz
X-Google-Smtp-Source: AGHT+IGm3qETp72yq8oGMbu6DJWKZg2Pdj3DkWjEN9nWmIhNOtmeYsjNnVC5K3qtOlkXFWuWXqyPwA==
X-Received: by 2002:a17:903:2441:b0:1fb:8890:16b4 with SMTP id d9443c01a7336-1ff573c4f57mr168818035ad.48.1722909555719;
        Mon, 05 Aug 2024 18:59:15 -0700 (PDT)
Received: from swift.. ([123.113.254.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592aee19sm75286575ad.282.2024.08.05.18.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:59:15 -0700 (PDT)
From: LidongLI <wirelessdonghack@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mark.esler@canonical.com,
	stf_xl@wp.pl,
	wirelessdonghack@gmail.com
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer Dereference&Use-After-Free Vulnerability
Date: Tue,  6 Aug 2024 09:59:04 +0800
Message-Id: <20240806015904.1004435-1-wirelessdonghack@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024080359-getaway-concave-623e@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Dear Greg,

Thank you, Greg!


Yes, as you mentioned, it requires users to create their own udev rules, which is not common among Ubuntu personal users. However, in some non-personal user scenarios, they must pre-add udev rules to meet their needs. A simple example: in some Ubuntu embedded Linux scenarios, we found that when starting a wireless hotspot, developers must configure udev rules to ensure a stable connection, enable auto-loading of drivers, or auto-run or write USB-based auto-configuration scripts.

Alright, thank you for your fix. We will proceed to the email you specified to request a CVE.

