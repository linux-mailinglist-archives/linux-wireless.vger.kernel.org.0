Return-Path: <linux-wireless+bounces-10988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCB7948819
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 05:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E7B281273
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 03:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D211B9B5A;
	Tue,  6 Aug 2024 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVcUuNWs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AD3BBF5;
	Tue,  6 Aug 2024 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916486; cv=none; b=sd7IgCw49mpSyvnI4JL4zYSA4WPLOrETVWRWai8Yr54zOII4svuvmMCbZIjnkGHBuWacxyPFjpqUyIjTl+2aXs/HpO0rabjiw74mQFHEjjNNogjTHZYbpd3JNNdycbHJAEeCn146n2TZgw7UON6e+iMolNDe8MOqI9o/te7z5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916486; c=relaxed/simple;
	bh=J49K3cYWUArLK8x1yjCzC181gtekpwUQiXcDMGd9uO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYOZ32FAaRYenk8AcAde+jWiUapYLqr0u9a/JKjhHmH4KpMka+h7SceCCzQlshIz95d66Dd4Xtj5ppGhcLKgDoGeKBkMcERk2wZlVEW2U+9QZq8CXNwfuOU8N1Mmqb0dxS8RsG2i9V5PCeducWoqBxdDRJhKpJ4v3HEZ0QgjD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVcUuNWs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cfec641429so231163a91.0;
        Mon, 05 Aug 2024 20:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722916484; x=1723521284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J49K3cYWUArLK8x1yjCzC181gtekpwUQiXcDMGd9uO8=;
        b=NVcUuNWs81aphIn3UsHIPe5DhKLK+rq1ud5TYwX/1DU5y8/At3k2GbNgr6TekQ1W6f
         iYkUTqBm72N2Zfak9OnxUbWsO5k08djgzBGM25qu1BnppaeirMPHOml27b1HbkcrkTTL
         EkZrRuIqEqyywanl1vzGqbTKI4a3GzJYS7www6w0hiviUS2TzSso76I5sFgjZjd7/GEt
         SiIPB3KPMNJZChGZeegCKq7a+24cuHK3fl4wW9gq7s5dyN9HoHHHld2jFFTzYDTJRMsa
         RIw5sVknMQV1+rZo+LhE0eVMtmj2isCDQYXE8yMtDEHfl0SYobPqvlhpu4WXO8EhOl6/
         xdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722916484; x=1723521284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J49K3cYWUArLK8x1yjCzC181gtekpwUQiXcDMGd9uO8=;
        b=LJRO6aehc4+jmtyyGXHL1eeJPSf3z1SOjtJxYPt6J4vFW20iP7E63pCWOxO7rGBdw/
         J1u3/qB+Zr1KaLqCnzQCgEWCTOEePnIXgB1i1gVnHRRoEbwbGIiQWIehykqykHK/Ji8h
         fGK8Id4Cr2R7OIsik1tLW0vm8ZJUUHVFNAX+qUfLTDKGPe1enO9hCbIsjRvNgF9UF6VN
         Wcka0Hmd7+01+faUNZ32wM2W8gX8igg8kxOSJ2c0S7PSf0GG6dEwObgjzB1aw/GCmdpt
         HZ/rw0fCTetGCh+F+Se89CC0vYMxkLnpVDvITyK/x62F46tWQjsuuUMmllQ+/lkK1g+Q
         0ETA==
X-Forwarded-Encrypted: i=1; AJvYcCX+u9pvcdkZyG1ZNB02K9OmIGTbU/yPx8DitpkCY/dnZ5UFZ3/l4ZMUsCfqX38ECxR4HsWzH9ez35d3mv7bleYfEvBedNPwYlRA+5XGFjZBKnm/ME9AJg5sBZ6TOgsiA8isa6Rn16rirfbPN/AqXEVoWivgQP/T5Z42siZ4Ito8+5hHKYkOmUc=
X-Gm-Message-State: AOJu0YxifcrWy+Wxta4VcLF/cKqdGqcn7RI4ewUis5k0/UkkmQxZbitn
	Smd5UVvt4iLcR8MxPyyCIYSSCRDMHYbrV4fm842DrwFNlyPF9TSAyEzLI3KTzg==
X-Google-Smtp-Source: AGHT+IHhWKClEsbgs1e+2zfUkzsV1vKpeHv4n/WG5pfmZ/WMqH0SY+HG+dVEbhLbZzHg59sxc21bsQ==
X-Received: by 2002:a17:90a:cf0f:b0:2c7:8a94:215d with SMTP id 98e67ed59e1d1-2cff94040d2mr12625900a91.12.1722916483871;
        Mon, 05 Aug 2024 20:54:43 -0700 (PDT)
Received: from swift.. ([114.254.10.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf6a6d0sm7963455a91.6.2024.08.05.20.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 20:54:43 -0700 (PDT)
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
Date: Tue,  6 Aug 2024 11:54:33 +0800
Message-Id: <20240806035433.20901-1-wirelessdonghack@gmail.com>
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


Hi Ted,

Thank you for your detailed response.

An attacker doesn't need to create a udev rule in the user's path because that isn't feasible. We need to consider scenarios where certain special devices (embedded systems) are designed from the outset with RT2X00 wireless network cards included in the udev rules. This is because they need to perform custom or automated functions related to the embedded system's operations.

Therefore, what I want to emphasize is that while this vulnerability may not affect users who do not have udev rules configured, setting udev rules is not inherently insecure. It is a normal configuration. Without udev rules, USB devices cannot be properly invoked or perform additional functions under certain conditions. It's a necessary feature.

However, for users utilizing RT2X00 drivers with this normal configuration, it directly allows the execution of the script without sudo, leading to a system crash. This indicates that the RT2X00 driver itself has a vulnerability that needs to be addressed. A robust and secure kernel and driver should not crash or dereference a null pointer regardless of the script run or the permissions used. We tested other drivers and did not encounter similar issues.

I believe this issue should be considered from two aspects:

1.The vulnerability indeed requires certain conditions to be triggered, but the configuration required is normal and necessary.
2.Running the script does cause a kernel null pointer dereference. Any robust and secure system should not encounter null pointer dereferences or crashes.

I understand your analogy with the /bin/bash example, and I'd like to clarify a couple of points to provide more context for why I believe this should be considered a security issue:

Normal and Necessary Configuration: While it is true that setting up udev rules is not common among typical personal Ubuntu users, there are legitimate and necessary scenarios, especially in embedded Linux environments, where such configurations are required. For example, in industrial automation systems, USB devices are often used to connect various sensors and controllers. In such environments, udev rules are configured to automatically load specific drivers or execute scripts upon device connection to ensure the proper operation of the system. This setup is essential for the reliable functioning of the automation process and is not an example of an insecure configuration.

System Robustness and Stability: Regardless of the configuration, a robust and secure system should handle unexpected inputs gracefully. In this case, running the script under the specified conditions causes a kernel null pointer dereference, leading to a system crash. For instance, consider a medical device scenario where a USB-connected device is used for critical patient monitoring. The udev rule is set to load necessary drivers and start monitoring software automatically upon connection. If an attacker can exploit this setup to cause a kernel crash, it can lead to severe consequences, including potential harm to patients. This example highlights that the presence of udev rules is not inherently insecure; rather, the kernel's inability to handle the input correctly is the underlying issue.

These points underscore the importance of addressing this vulnerability. While the initial setup requires root permissions, the critical aspect is the kernel's handling of the input, which should be robust enough to prevent crashes or null pointer dereferences, ensuring the system's stability and security.


Our requirement is to assign a CVE for this "bug" because it is an issue within the kernel. Since it is a problem, it poses a potential risk. Therefore, we believe it is necessary to address it accordingly.

Because it involves a driver development error, we believe it is necessary and meaningful to address this issue.
Cheers,



