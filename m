Return-Path: <linux-wireless+bounces-8802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC0B904092
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 17:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912AD1F2191C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D395383B2;
	Tue, 11 Jun 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aVSyvUen";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KsY3D4US"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53E3839C
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121256; cv=none; b=pVO/yjPosN0hH1YEXH6+UFKdySTyf5Mwc4TqcVY8RktO1NLa5rWncXlTYIjckV9BMEyi7LB60QFmeS03GRsjS448F7ZNSI7PMIb2AaXvtS/yG1slOFYslc1dLY0zMRPusVRMUjTJhLpThJUPnUm/tYLdcoHsLODx5u7hbu0vRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121256; c=relaxed/simple;
	bh=rqtYafVQvUsVK/tCtTwRbdRqcxbkSR9hFIz8Q4R+tbo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dZvFsHQ1seGE7TEndawBFYaH2pydTjvaZ5lk1rUVHAD6b9uwr0Mdh9bP+RrLXC96P7EQAy9AroCy/ANTDZq3nH8yHjAJ94cqe7o+qQAYTU55JSeXq3eJ4QRxUvQJ7Ow+ymZZ8gRQeFZJ8ksK9BZ7GvVrUqExwDMNZ1PkNaiQDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aVSyvUen; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KsY3D4US; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <ee08c815-9389-4277-be6d-197511636892@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718121250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IfakeLpXBgh4eOEoo/KB2bFACI8Pm/SnAE7UOpqrB70=;
	b=aVSyvUen+JVvYSI6l0Waj05dnu8U3ltYQzJ/rd0TtJqaUw0NbMaZsVNUxWMpoxhgdDB1ND
	0y28YFCnjRlJGSVucr5DMKqtabxjZDSStX1sjD6wfvz8IJDM4ZxYCl3ZT79ksmJxpRhvHq
	Y3fdIkDKXaohiCy8CLwBPCd4cbzx+9q1WxvurAkb6qZA/F3pTMMUwr73wrwq5REk2i6nyk
	10KO1MIQiBB9447c1qqtD/2xdRBfaaaYlFvSu18hFOsGUQG/rOIM3yfiM9vjHW18VvUhse
	hjOWakrzM7Aah140LEeDCyJZeEXL6hlduZ6Si/mmi4JLynAfwh/+Zg3Z+57VhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718121250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IfakeLpXBgh4eOEoo/KB2bFACI8Pm/SnAE7UOpqrB70=;
	b=KsY3D4USwq5XUcnpS3qd/dDcZesgcErUKctZvF0XYzVn0jXT/jjGFbyioAW5xSZS2Klrtw
	mlv4fzCtRqk0D3Ag==
Date: Tue, 11 Jun 2024 17:54:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org
From: Martin Kaistra <martin.kaistra@linutronix.de>
Subject: ETIMEDOUT with rtl8xxxu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ping-Ke, hi Bitterblue,

I have a problem with the rtl8xxxu driver and 8188f, but only on some boards. 
More specifically, I can see that during the second channel switch (which 
happens when I do "iw dev wlan0 scan"),  the rtl8xxxu_read32(0e08) returns -110 
(ETIMEDOUT) and after that no reads or writes work anymore until I unload and 
reload the driver.

The strange thing now is, that even though it seems to be hardware dependent the 
vendor driver does not have this problem.

I tried to change the probe and start functions, so that they behaved exactly as 
their vendor driver equivalents, but so far I don't see any improvement.

I was hoping, that one of you maybe has an idea, what could be causing such an 
issue and how to avoid it.

Martin

