Return-Path: <linux-wireless+bounces-9469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9115F913F8F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 02:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95C51C21173
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 00:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292610F7;
	Mon, 24 Jun 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=animalcules.com header.i=@animalcules.com header.b="uXQBZYdI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail4.animalcules.com (mail4.animalcules.com [45.79.49.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2E646
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.49.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719189202; cv=none; b=MI0EYo6jAUX1lOVfCAf0IJKE8W0YEWdKeLYcrQ+1Z1rJKxdNIqB23s3JirlisFKeNTj5PltIB+mqSWnBxuzZAHuB9QtTm1bwWV+zg8UcWZVlem7NE6oMskTMCKVTUhJkr1p9reycu4mAwbZJzvFUArd8ZCxN5Nop1j9pQ1OvV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719189202; c=relaxed/simple;
	bh=6sjpscYMfhd4p8HS7u6QeSb6lBCzm9Kx6807olSYgHo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=b+ra0PnDMn6JgLjMZvsNyJjFw4/s9ZKDofVq/G4ORKOLw/+aMbMonlVH6NcGRGrpPo4O+4dtc/wusJNA+eel5k+oPzqBqqEiOXvN7n5cGh1uFAElJQ2qZwEiIHeOWEvbmqQrjzavAuIU7ma199hpS2sTQfpdf7h76Y+H4SU7Iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=animalcules.com; spf=pass smtp.mailfrom=animalcules.com; dkim=pass (2048-bit key) header.d=animalcules.com header.i=@animalcules.com header.b=uXQBZYdI; arc=none smtp.client-ip=45.79.49.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=animalcules.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=animalcules.com
Received: from [IPV6:2605:a601:a5e8:6000:b621:6162:db60:5323] (unknown [IPv6:2605:a601:a5e8:6000:b621:6162:db60:5323])
	by mail4.animalcules.com (Postfix) with ESMTPSA id 037AB74F2E
	for <linux-wireless@vger.kernel.org>; Sun, 23 Jun 2024 19:25:40 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail4.animalcules.com 037AB74F2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcules.com;
	s=20220111; t=1719188741;
	bh=6sjpscYMfhd4p8HS7u6QeSb6lBCzm9Kx6807olSYgHo=;
	h=Date:To:From:Subject:From;
	b=uXQBZYdItTYcobPNA4rV8uzNKFKx5OOykOpla+Xc3RLL5Q5TlILInDHhv0P3dZ8am
	 6PHFY8IiP5Gp8qj3aKSN6eQAqH9enTgDVOnPWISYJTj0tkUeUxac35gkipfEK22mej
	 ZGQswPnX89kxaY7lE5as+X4I2/riUVDr8R9Bxv54el8Sg6Q3hzUwO4DIC6kYZabQca
	 Hq2uwnHAwqdl4w1CCNQFRZdnXA86LM/bTw0RtHTA+FFCwtYM3rmoVQkYPUu4ZP/a6z
	 TF2bbgiKwbPp6vtZe6x7dOGPiJ/TxtpMlseqaLH0k9m5PVaulTvRUDNT2UmEimTbSj
	 KvtqNxwoqDyjQ==
Message-ID: <d6f2e068-ef28-443a-9d4a-6e609dd62b0d@animalcules.com>
Date: Sun, 23 Jun 2024 19:25:35 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
From: Paul Rotering <rotering@animalcules.com>
Subject: subscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

subscribe linux-wireless


