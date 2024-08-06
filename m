Return-Path: <linux-wireless+bounces-10986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D379487A0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 04:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96E3B20F20
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 02:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032CBA34;
	Tue,  6 Aug 2024 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH//y+kG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1751A5F;
	Tue,  6 Aug 2024 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911698; cv=none; b=fzL8AH0OrfsKgyv2eOXOybrvw91Y84FVzB822fIUwJUuKshCU8uqeTAuU4qJVzyyv9RWu8u5L4FgmtSFIuZCoCGHP2J2gHfTuXKu1LKH6BzL7hXksKpIITxzj8Kf0cqqTQAonJVRCQSHMq87BLMwAlYnwk1qNN8OyzTSXy43Is4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911698; c=relaxed/simple;
	bh=EbTbx5p4al9ZaIbKU/7YbuoPhU8koEq//rj/BwkxzOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hf/rSUVK4ga5RWj9af4PoeD91sJu+CGCqAZJ9TgveWuOmK5grJEVA/I1cAoE0fCqg2YzO09zu62quGJqYaqwUSfGRdIyNF7xbgfWD89jkcKxtwl/39mvfd4cxcoHE+fWmMP+QDn8RivGTzLOlVSo+3jjwdKF3Ck5GNMTn4pFGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH//y+kG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso119345b3a.0;
        Mon, 05 Aug 2024 19:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722911696; x=1723516496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbTbx5p4al9ZaIbKU/7YbuoPhU8koEq//rj/BwkxzOA=;
        b=XH//y+kGlo6m1yY0goRboT91wF8bWr6jG5VmL+JtKqSrC/hWj1VsJtV3JBVNuJNdX8
         YecXS3bFQRmBa+izkU47ZpiJ2x1E3g34qjyS7PwM+oGyoCHIxHnIJU4Vxq/gLg6jU07+
         nahI522SDsw7lr0twVcncueV5Mu4ye5xDPnYEznSoq5yuxwRM1QCMh+jDhpxXgVmVumE
         fGsgN6jFrtAyg+2zXy4uDUONLSrHOGjxo5Z2Q57VhkJBx/YX+/DgrvJYfWKcOM8kKeFN
         tJb2f9iITtN70DrO6smoDjIbKDBrZAlE6Bt/hruymLpGAy0BK6iV00DRnRoKQBVAZLnR
         iR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722911696; x=1723516496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbTbx5p4al9ZaIbKU/7YbuoPhU8koEq//rj/BwkxzOA=;
        b=jnvgTK0Q66Dih29igMo6J/MoYa47Jr9/es8L/jDTqDYxst4Zv+uqW8KhSe7GXcr9Zs
         UoNwzqQurmtihvZN3ABT0a0nf8MBu+wh4v3SXP2+0+nT+kMUr2D1fBY8c6zI8I761WIN
         TS2HZB7o8r+jUHG5o6ylcog0bgoooX5IceZ+HM3pqEV7UKg2R9XWV82fJLUGkAOCvtlk
         qZnzv5x1gWMwXxuTW6xb+MhkcZ8panJ1mQPN5hgl0c9l8Iz4+gA5IMpqTUcHvMXCMyAg
         BekLB5+AGgC5d0tpMfOroeTkEfBNWp3xoA5cCNGxBLmgKRboJDaQ10ZOdK2KllK25cVs
         iIUg==
X-Forwarded-Encrypted: i=1; AJvYcCXcw47eZkqAB1vDC2j8ygV+Ixp2IkhyFH+lDN746gtOCBVQkAOZdyMuBcDzjdhog+YKRyy1KZn8rbc7h+TVoUDOugjfW7yAtfwPyD28sWoeDJ8vJBwDW42yzq5ZNZJ6XsFcwHSUXFhtIDm0v5kDVDf2ireKeJk4VcwQT14MHI4ck6c2t1c1nss=
X-Gm-Message-State: AOJu0Yz5jUn6HmXJ/yuXPpiscljRmtf6pAE7n445wzJMaplDQgz2OBxO
	1xZ53OBAK+FdeEZwwF9/wB8zyGuFlb1pcvPJTNyX/fRLGul2UCE=
X-Google-Smtp-Source: AGHT+IHXOzZ4ddfolu1RXpOguukaAJ7UtFFUp3JUbkssk9U3Tq9rmnzw6RZJwZzR3wy5jA+gghrH3A==
X-Received: by 2002:a05:6a00:238b:b0:70d:2796:bce8 with SMTP id d2e1a72fcca58-7106d02f8bbmr20100111b3a.20.1722911695932;
        Mon, 05 Aug 2024 19:34:55 -0700 (PDT)
Received: from swift.. ([123.113.254.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed31c75sm6053559b3a.218.2024.08.05.19.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 19:34:55 -0700 (PDT)
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
Date: Tue,  6 Aug 2024 10:34:50 +0800
Message-Id: <20240806023450.1040873-1-wirelessdonghack@gmail.com>
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


Here is a scenario where udev rules are necessary. They can be used to automatically execute a series of configuration and security operations when a wireless network adapter is inserted, ensuring the stability and security of the system. An example is as follows:





# 1. Create a udev rules file
sudo nano /etc/udev/rules.d/99-custom-usb.rules

# 2. Add the following content to the file, replacing idVendor and idProduct with actual values
SUBSYSTEM=="usb", ATTR{idVendor}=="148f", ATTR{idProduct}=="3070", MODE="0666", RUN+="/path/to/custom/script.sh"

# 3. Example of a custom script
# Create a script file
sudo nano /path/to/custom/script.sh

# Add custom commands to the script file
#!/bin/bash
# Example commands
iwconfig wlan0 essid "MyNetwork"
ifconfig wlan0 up
dhclient wlan0

