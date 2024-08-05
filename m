Return-Path: <linux-wireless+bounces-10943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656294775A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74503B21468
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B81494D7;
	Mon,  5 Aug 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3/frPr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748876BFB5;
	Mon,  5 Aug 2024 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846828; cv=none; b=jXAiJQFaSOk+fVdYOhYemBKLy68rfPHHcBr5gWlHUpmSpR7CWHdF30YilUN5/J+egQCgViXwEcpJSFIdnVOJzoZDc3fWTRgn4tBBf0qLhUuVIEOugvqSFCfwWf0rCf/RCFCkl0tegXhcO5dNiBIDlO7FDpZtlZ4gNtvZEhA5PqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846828; c=relaxed/simple;
	bh=2KhrN4SytIKXvlaVk8LBlBn0K8PEha4uO2c0hSvYAGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6fYKfplWaKiEVZNURZWTJtcbXDBiKR7FIpDQpTgINASv5Lk4H6BPg0xEQu275EDtzlD6WnBNCSy3JSF8qqZZ6Z3Ucu0uFTSEx5vSyNDb4d1ucoIMaHJmbEHdJ6YkBlxas4yPWgiFskFy/0wiZspvlwS4PPGc2tgEQZEp6kOlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3/frPr4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd640a6454so76705625ad.3;
        Mon, 05 Aug 2024 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722846826; x=1723451626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhfwIyCfWpcFW86qWaVqqtr9F82JOKP2kKmTKQ98Y2c=;
        b=N3/frPr4rj36I6e6DUtHepo5y/F4yHG49/9AmooJcH50KEUkJv5bi4K1zNRw8fjm5D
         Odgl8Sm7Hm+3ihWcUM4SDshhZMzveKJFajNEcgglAiRHwJkBp2fITl/l+DzA0qwTAOer
         1qqIwByOrorWKmmTO9xEkEp2fPtabhRh/ZAoDJz+hdgqFJ0fWYJrtUTIM44NOtaAP5gO
         9SOeIz7wWc3uJ4o1/0GCMfcAwrGMk+Nqnx1FPkLssobRN65zyZdPEm+GwquI//zOJvEC
         cRCyhpMVN3f9lph260wiixS2OV2Gh9373ZILvoYOWUfH3scn+8gtzE3S718KTwMPaZKx
         KYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722846826; x=1723451626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhfwIyCfWpcFW86qWaVqqtr9F82JOKP2kKmTKQ98Y2c=;
        b=IYeZhtLwlhWBA6d789MsBJhlowIn6GPe0eABRikDr7kWQlptZXC4LqDsmcUvtg8vof
         Fso5F3NpQi08+UV1/lL8B4KgXVoXzcrKTSsjF9a4BHSscJICe+8K3iSghcMC21b4gP2T
         03Fr7hcTBsjNmyIfvGoMEvmUhZToo32nj3tqJ7o8lFHlonaBcMwNXHjv3TsSIlVPCBOl
         1Rh/6nzACafrFhPr3PIw11kvP/W8lCqxz6EkPyuoTZT/lQDwZz91SKq5HFOZKzekDqXJ
         syQBNs4X9YVbWAFyQPT7ik6zDkoACOSMvBbwH54MXBC269zuwy0ImbrKERXlOzlrYoqF
         RM1A==
X-Forwarded-Encrypted: i=1; AJvYcCUKZ95rW87hllMegbcGuhHRqDvLw0H6dS5F41ZNYA1vzxMBeF8sj50K5Jjia2l3rBKqUPUeYc70SSvpqxKdST4Ao0hWmWa8CJBejixBEu05dfaFVoUg9tOs0L/rNHx/AW0kMpuG7dvA0wInyh0pwZSDA5UC+ZZkrUzhjFjLMJ+WkKSNOVWggM0=
X-Gm-Message-State: AOJu0YwIWq4xmD4owZK9iPt+gPfvMCWsdUnLnDQBSgZjSdTHasOLAr4f
	+wve/khOh7/S9yHicsWKiSjNk05OVYLPlIUoJgN/awCJ8vEAmgQ=
X-Google-Smtp-Source: AGHT+IE7S2iQXgJH0jMC6FFzwGdLvo08Xkd2KAkMGFussXMJti3r1vfLCnAn3uuiPQj+KUTnjNGUTA==
X-Received: by 2002:a17:902:ce86:b0:1fb:bd7:f232 with SMTP id d9443c01a7336-1ff572bc46fmr117540665ad.23.1722846825436;
        Mon, 05 Aug 2024 01:33:45 -0700 (PDT)
Received: from swift.. ([221.222.21.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b8a38sm61583245ad.307.2024.08.05.01.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:33:45 -0700 (PDT)
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
Date: Mon,  5 Aug 2024 16:33:39 +0800
Message-Id: <20240805083339.10356-1-wirelessdonghack@gmail.com>
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

Thank you for your response and for considering the details I've provided so far. I would like to offer further clarification on the vulnerability and why it warrants assigning a CVE.

### Detailed Description of Vulnerability

1. **Root Cause and Exploitability**:
    - The vulnerability in question can be triggered by sending specific data packets to a device driver, causing a Null Pointer Dereference in the kernel. This results in a complete system crash and reboot.
    - While initially it appears to require root privileges, altering the Udev rules allows for exploiting this vulnerability from a non-root user space, significantly lowering the barrier for potential exploitation.

2. **Impact on Systems**:   
    - The root cause is a race condition between the userspace resetting the device and the kernel driver initializing it. This is not an edge case but a common scenario that could occur in systems where devices are frequently reset or reinitialized.
    - By manipulating Udev rules, an attacker can create a persistent and repeatable method to exploit the vulnerability, leading to Denial of Service (DoS) conditions. This can be particularly disruptive in production environments, impacting servers, IoT devices, and embedded systems relying on Ubuntu.

3. **Practical Implications**:
    - The fact that this can be achieved through Udev rules modification is significant because it demonstrates a path to escalate privileges and attack vectors that can be exploited in real-world scenarios.
    - Systems that are exposed to user-space applications needing device resets or control operations could be particularly vulnerable, especially in multi-user environments.

### Experimental Evidence
### Setting Up Udev Rules: Granting Permissions to Your USB Device Without Using sudo

To grant permissions to your USB device without using `sudo`, you need to create a udev rules file. Follow these steps:

#### Create the Udev Rules File:

1. Open a terminal and create the udev rules file with the following command:

 
   sudo nano /etc/udev/rules.d/99-usb.rules
   

2. Add the rule: In the file, add the following content. Replace `YOUR_VENDOR_ID` and `YOUR_PRODUCT_ID` with your device's vendor ID and product ID.

   
   SUBSYSTEM=="usb", ATTR{idVendor}=="148f", ATTR{idProduct}=="3070", MODE="0666"
  

#### Restart the udev Service:

3. To apply the new rule, restart the udev service with these commands:

 
   sudo udevadm control --reload-rules
   sudo udevadm trigger
  
Regarding the discussion on permission issues, I would like to further illustrate that it is very common and reasonable to configure similar udev rules to allow non-root users direct access to USB devices in many practical scenarios. Below are some specific examples:

Educational and Experimental Environments:
In university courses on computer networking or wireless networking experiments, students frequently need access to various USB wireless devices to complete their experiments. To simplify permission management and improve experimental efficiency, teachers or lab administrators often add udev rules allowing all students to conveniently access and operate these devices without using sudo privileges.

Development Environments:
In software development companies, developers often need to debug and develop network-related applications, such as network monitoring tools and WiFi management tools. Frequent use of sudo privileges reduces development efficiency, so development environments commonly configure udev rules to simplify permission management, enabling developers to directly access these USB devices.

Automated Testing Environments:
In automated testing labs, test scripts need frequent access to and configuration of USB wireless devices for performance testing or connection testing. To ensure test scripts can run unobstructed, testing engineers would add udev rules so that test scripts can run without sudo privileges.

Custom Devices for Specific Purposes:
In home automation or custom devices for specific purposes (e.g., homemade NAS or IoT devices), administrators want to ensure that certain USB devices (such as wireless adapters) are plug-and-play, and the system can automatically recognize and configure these devices. In such cases, configuring udev rules to open device usage permissions is very common.

Embedded Systems:
In embedded systems (such as routers or VPN devices), it may be necessary to configure USB wireless adapters to expand connectivity. These devices often have a set of default permission configurations to ensure that wireless adapters can be automatically recognized and used, avoiding manual permission settings each time.

Based on these various practical application scenarios, even though the system's default configuration might require sudo privileges, these real-world configuration needs are entirely reasonable and common. When devices use udev rules, non-root users can bypass the default permission restrictions, making race conditions a significant security vulnerability worth attention. To ensure system security and stability,


### Request for CVE Assignment

Given the above details, I believe this vulnerability has the following implications:
- **Denial of Service**: Potential for attackers to cause persistent reboots and disruptions in a variety of environments.
- **Privilege Escalation**: Demonstrates a pathway for non-root users to exploit kernel weaknesses by leveraging standard system configurations (such as Udev rules).

Assigning a CVE to this issue would help track and mitigate the impact across affected systems and emphasize the critical need for a patch or workaround.

Thank you for your consideration. I look forward to any further questions or clarifications needed.

Best regards,


### Tips for Strengthening Your Argument

1. **Provide Evidence**: Include logs, stack traces, or any crash reports that underscore the vulnerability's impact.
2. **Highlight Real-World Scenarios**: Describe how the vulnerability can be exploited in practical, real-world situations.
3. **Be Precise and Clear**: Use technical terminology appropriately and explain any assumptions or configurations required to trigger the vulnerability.
4. **Emphasize Risk**: Stress how easy it is for an attacker to achieve their goals once the Udev rule is modified, even if it's a non-default configuration.

Remember, the goal is to present the vulnerability convincingly as a security risk that needs to be tracked and addressed with a CVE assignment.

