Return-Path: <linux-wireless+bounces-11051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A1E949D9C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 04:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD552859FB
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 02:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BFD5FB95;
	Wed,  7 Aug 2024 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOVFMPgw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B72BB09;
	Wed,  7 Aug 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996722; cv=none; b=W6IXcNMiVgf05K3lxGNV9vDW9AjECspxOcr8+JWH3L6Ydeyb2GXRBwG4BEHJYSym7kYn1fpErKRMYPIvQhbOQRViBTOxhoXWTGD4O2q4tVksC7lMMHQM+YowkJvAxV4UQ86/OHyzSlXq05oYc7HhmDDdoqa9KjZV0Kbj2MDDYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996722; c=relaxed/simple;
	bh=44WDQBza0lcKUll2NGUPxK2VGi0L6nAGFIU5xsX9pKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VW4jPkYzPwJziMrgTmnvkY5hhcyCuZ87t/5OAjREWCwmTdoMsnaTDWvMx3zt2Buhum74+wk8VZaFiwh9mpjBb+FYuiYfpKMJn7bo5V/GUvvgvK90IhlZIjOOv+VgaiVswkOdSK+sOCLsnmqbaXDE2fQdfQkI6UB0JkwFp6MFTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOVFMPgw; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1270da60so806406b6e.2;
        Tue, 06 Aug 2024 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722996720; x=1723601520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIr4fcH/6RBz0tisKFlvXXUTv5tES5dflg1RDhO5Thc=;
        b=DOVFMPgwqP5AZxGbgHr2QTwnAg68TyAcUWQz6coUwY5xAuSfGG+5sb/9cw4paih9eQ
         UQatc5NtrpX3xAu8QoFKWZP7HsfY/wbDk3FMOhDfz58Go9GBuTCK0qTTpSplkSIKOLiE
         7OJk3LXG5K1Ycdw6DYQoxzcxPDpbw38G/VrQgIwM7K/8b9sqT16SAvVpwIAqNsMOgEwB
         nA/W4Qj3SffqDtRUo7SnDcD0lTUg317GDwHiNgGJ3CSSTltF0qb3r/gxW35OZM7VQyxu
         fUWE/EWWqCskAXVasAnsqRcQRFjdwKKpYUMyqEeMWSbwZ83aCJgJwpYF/Xcj4xUv9yyK
         CMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722996720; x=1723601520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIr4fcH/6RBz0tisKFlvXXUTv5tES5dflg1RDhO5Thc=;
        b=tRbEWxdzdqDyVvNJZTteb37td4FxYc2CsbjchQHhR8cgl9blFn++u+inG+0SEmrCtn
         yHncNqJBmIIin1N05CTZ8GB1w2Okz7e+DppzmlF/2ohAZbVOA0a+XWubAknPoTm/pz06
         hZaoKllR+rqYXWJYdEuYBLEQivJ9fAqj8bX0J6B4aHmcnYAFTfmWT8J+AG6lWw64Y4iD
         cYayGOxdxBN4ncoh6lhNqpbGRpXym528VQKX934pT+4Tk4rupBOzVvaEJInNfvoB0ELl
         q2oD9jdUJnaWCl85OXdFMxgO5xPpf/EbYvMxnR9mQPC956583ENIWAFpawTrvvPcvwYB
         kymg==
X-Forwarded-Encrypted: i=1; AJvYcCUBoptXdgfvygTpRJgYi2GLMRJ8UgbpiaMcseGYKeWSUZYo5wPoshU6ups8uUzcW5CiAHwFO/5thrfYTyfxT/ZN1DMUw5aD4h3BNHlQ6XRtrxesCtGTojxExB0l6e8LI2d/tzdaiDsP0G7ieZADmfVv5zi2AAC+y4qOpAWHVuskKEovCj7E6+Q=
X-Gm-Message-State: AOJu0YyNu6fZ6fa6lVhFzO8Q/BaYIR75965HKHiV43FZDumm1CxkNIFF
	8E+U2Srxr8MRrwgduTrwzvQMiqvOjq5sfK2YEIgTDxt/ykMJfRswMENU3mT7/MFP
X-Google-Smtp-Source: AGHT+IF47oPVx1N8yrrTBkzTqcQwPch8CBXirgw69xrsWGlzzqWhB+8gjrTktNXfY7nqdlLrxZrdrA==
X-Received: by 2002:a05:6870:7187:b0:260:e611:c09 with SMTP id 586e51a60fabf-26891f27131mr20472153fac.47.1722996720371;
        Tue, 06 Aug 2024 19:12:00 -0700 (PDT)
Received: from swift.. ([221.216.134.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec74068sm7773029b3a.95.2024.08.06.19.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:12:00 -0700 (PDT)
From: LidongLI <wirelessdonghack@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mark.esler@canonical.com,
	stf_xl@wp.pl,
	wirelessdonghack@gmail.com,
	tytso@mit.edu,
	stern@rowland.harvard.edu
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer Dereference&Use-After-Free Vulnerability
Date: Wed,  7 Aug 2024 10:11:52 +0800
Message-Id: <20240807021152.10474-1-wirelessdonghack@gmail.com>
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


Dear 



Yes, dev.reset does indeed require root privileges, but what we find abnormal is, as I noted in the POC, a normal reset is not problematic. However, after time.sleep(0.1), it triggers some issues.

import usb.core
dev = usb.core.find(idVendor=0xb58e, idProduct=0x0005)
time.sleep(0.1) # It actually needs a sleep of 0.1 or 0.2 seconds to take effect; otherwise, it follows normal development logic. For example, when there is an exception error like 'resource busy', a dev.reset is required.
dev.reset()




Thank you for your response. Yes, I am able to test patches. Please provide the necessary patches, and I will conduct the tests to verify their effectiveness.

Best regards


