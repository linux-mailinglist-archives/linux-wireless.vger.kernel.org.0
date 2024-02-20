Return-Path: <linux-wireless+bounces-3812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA185BF65
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 16:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183801C20BA2
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921B43AD3;
	Tue, 20 Feb 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b="X8bFAdBG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-200161.simplelogin.co (mail-200161.simplelogin.co [176.119.200.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26E6F53C
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441436; cv=pass; b=HFSw4qZoDKLCXAbRN0irE5XnumuAKfJbqq97UowwQQYIomee0/5b9dS6I0Yt0Y8tQmzOLk/v/TL8n8Gv8RPTxxcp6C9VptZSALhTGS8UiNfZ7S536614CqTFIkI8rDY8QMo6ajMoftz3w7qarRJ4pim65C8G3UwK/i5eGTIC4OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441436; c=relaxed/simple;
	bh=XeaP09Z9FGz0qtsjOYlw2hulM7eYjmxNylcye3Gdqw8=;
	h=Date:MIME-Version:Subject:Content-Type:From:To:Cc:Message-ID; b=dYoE5TmDZVcV+zXlC7spzUejjQvQd6GsMpkIwH5SdWmIz/JM6xLcNHWl50aYREeS5BCt1KeEH1JrPpd7nvz1VWxQ5x1v6LTZ+dsqLV9HKjmfE8QtXGgoQ8ER62/1eNw2cdFmKE+sRcB5+Y06zL7TIFiKmDm5WakBIH6eHZZODYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me; spf=pass smtp.mailfrom=slmail.me; dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b=X8bFAdBG; arc=pass smtp.client-ip=176.119.200.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=slmail.me
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1708440964;
	cv=none; b=MaYx1JOoY3CxQGCrsbF5YY4oxFgD81So++Z6J7X553JqrCrn6mCyjBnL6GCqc/MbM9aCki+yp1ATcfCghievgFhIZaBOOZMdE7GwfQOuyRr0AZcbF4dW11Q8nO3bTgoVAPdNLqgKXWPmAvDFVrYeK6CLhCEKqpYdGCAXfzd+SPRIapMv2zgGcqL/p9mhww6Yo6Et1A6TGml3moLXe7O3w/kxooCMZL5AhiDAleOkROcSjnmuh1LzTa/Fo8pNFsprxLhWQtkW+1lz8Jru1QBAdCu91jsYY4NDQfLYHIMb8MF+4QmbFdo5aY7O9jn8WC4GLMG+mD22DskNNdZ6ebFHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1708440964; c=relaxed/simple;
	bh=XeaP09Z9FGz0qtsjOYlw2hulM7eYjmxNylcye3Gdqw8=;
	h=Date:Subject:From:To:Cc; b=xjtIa3iVms0kXu+llZqa3+bPiyBEkNy65ZhObuU0kocgnzkyWz1VxBjifHMOWStWcNpHcLY5NmGfilUltM2Hv+lnchqNolswbod3B37xHkFy/OWsvbSDs0tBoAa3/p25qOMfOrMEk2plvqWeZ7AZO3hXzuZzTXl59vTANm/nBVzj9gwYgG7p9H3sKqDjEtxP4vEyegHYzgDeKrzW35lrbOizFFY47BQEWImtnTYKj3KKAIIPTA2jfBdpsXP4GsFH4TYLXVMfzHqN9gNcOXSmJf8v14vv1tYUiNAlC2bEzOgPodqsS223au6EZnaBnk3QeOITgQYfpjbSdNA97kgu8g==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slmail.me; s=dkim;
	t=1708440964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ChpLJaTLq0LJTLESn9urwzAUyb+jJ6zuPcJICO2J3bQ=;
	b=X8bFAdBGA9OPpetSdib0FX1OiNon9Hdu5XxVLo6hwE7EBnlubFpf/Fa8Niz/78k9yaYqmB
	F7kCyeYQe9/U6E9JVV3RCeVKGe86sNVleslPYoZS3ebWipOGuZAqyM8KBbKvQB00lHZm5S
	6712eHRvXkJ7kclkzB9mlLnBpKRjsOI=
Date: Tue, 20 Feb 2024 08:55:59 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: PROBLEM: iwlwifi null pointer dereference when debugfs=off
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
From: drastic_endurance425@slmail.me
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Message-ID: <170844096394.7.10031732457351764961.271076804@slmail.me>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 271076804
X-SimpleLogin-Want-Signing: yes

Hi, I just filed a bug at 
https://bugzilla.kernel.org/show_bug.cgi?id=218514, hopefully I'm 
following the correct procedure at 
https://www.kernel.org/doc/html/v4.19/admin-guide/reporting-bugs.html . 
Bug report body:

Some commit part of the 6.7 kernel series has resulted in the bootup 
sequence to issue me an oops. One of my kernel parameters is debugfs=off 
and NetworkManager exits with a kernel NULL pointer dereference. This 
issue is present whether I use the vanilla kernel 6.7.5 or the zen 
kernel. I attached my journalctl

Note that I am following the advice from 
https://bbs.archlinux.org/viewtopic.php?pid=2151971 who suggested that 
commit c36235acb34fb3a2916558d3845203cae181e0be may be the issue.


