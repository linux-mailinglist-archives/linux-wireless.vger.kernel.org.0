Return-Path: <linux-wireless+bounces-31889-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN/gCGtOk2mo3QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31889-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:05:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C171468A1
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBAB630125C4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CAA29CB57;
	Mon, 16 Feb 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZldnLRlH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06917A2F6
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261544; cv=none; b=cGoK1SXjCC69HpU1T8G0b+mQNuMAuhB/n0WceE4JmPuYwXVGCU9qeQDQb1IqrUOvCMrEaI/OElTjUSAFqwh68z7Msh4MKlAfL7exe1oowrgY10xQqdzKSVBvAMbc6fK432w1bxIFV+MVlIB4KKqu3BfxGAuQdVJi0jzr3j4duPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261544; c=relaxed/simple;
	bh=a7sgxiGpzhgq75ttVTTRsPJYSBT5nLC4xvjzkjJh3S8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Anx6NQeUkSRlkE/GWfCdKHRCyDeuKSJij10AWC87ujLBKMTlXCIkYRuRxALt/fIbBkkEJHJxdKBbEOL2LgT72TXv0vn4lZZGPm8MlcOHkvFOO+gT6zYHQYQlZxEdqEDGULLfj5+uRNL/HxwzGY7ew8+bV3CQYtYEj44lUxX4Zlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZldnLRlH; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2ad21f437eeso15044305ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 09:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771261542; x=1771866342; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbySU2aY298dlatuqxfDkqAXu0CIdhl7AM1X7/ysfCw=;
        b=ZldnLRlHJEyI7vpDDSOnsKBlYzFDE2G4MUWkAhvhXmVf8+oOs25zHt79EAG6B2KHUA
         Eylz5wjoQYP7SdIqYmwUi94XLA9GHhL3nBXzh4z0VEy89Jrq4oYmN/Dmjod/0xPN0fuz
         AzGhFgSIgGNiwQ6KsCX1JVfQfHYKz7yKT2pnPKxUW3Z12YRYqWHGIAQAQgsxefANw1Ju
         YjnW8Uw7/dx3kHpnpJH0YsKvNLg2cF0C0OdE5vlMa6MXdlZUxVSvZoaRKOHIKbWGQ6/G
         rv+Fa7i29+SmG48Fid1nvhyob0CE+6OBF8Z/4FLswufh/0BtBEYZ+X5GvRQqS7Ymveyx
         Cc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771261542; x=1771866342;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbySU2aY298dlatuqxfDkqAXu0CIdhl7AM1X7/ysfCw=;
        b=p9ZlmUhIJSX+dFtQTaL+G8swKZyuxRF95Kz6qTvs3xIWJRzrRWDcDBRClqwepiPe1F
         S4R8iPuiCczXhqvlVGk0LCkOQKNzKu52Z0uXdeJNECbZw/F0b98B0HqhLNxTqKLh4H6b
         qilsRig9phNR2zl3Zh7HI3LKky7TNNo05rzCalipfzKWqV9frDDc6+dbUjwaFAgI7qbu
         ZMlpkckYnaUhUlZT9mav1Zeae0LaT0/Rn6z/syn6NelPKK6v6s1EDdRsDO+80oRUN3Is
         uoEVWcqneRkQkKBsPkGskuRNT5THLmP2s+KQsp4Rx120uEwXhFcOfwukc/K1YDouNIzu
         BkDg==
X-Gm-Message-State: AOJu0Yz1OD3h+Xee6jsKG4lW6Xw2Qf8VrWQhBpYPY7PltzPZmBeKLoCe
	Ict4dGJdQNEQmS72Cdkb/YcKUI0xrXiDn4hiVOxfTR8erGN0WYmEm+oOBOJid9SP
X-Gm-Gg: AZuq6aIrdRm0netzrN1AIxinM7V+hYB+r06OEsK7cTKKyW7P8cU1TRz2jzS4oFjRGQp
	TTaWk4rKxYHQe8LNIqoS79XiCRLzyelZhWxG6XwrNjcfKNVNzPKq8tqLlo/MdYBRbw1zO1CJQlr
	Ur/aLEQp66skU1snFbnUKtU8kIaCHGCy7DWH0VufrzMCRK8AYnpnwfiyqBs4lCZGkYapI3GEPKq
	0pkbKS2JGjzf3W6MnaAJ2SR7+ACFQGtPoM11jg/AJuaOSExrsfqPMYzsGhyzu1U6/rBvpdSKUJI
	KhIuxJUOVwyJJUbVxiqV94qAlbLM9K08P+xwiamPSGtTneepRSbejBIMC4np5+qrLXeNUh6Zg5F
	k45ZuU3tKn5csiK2vOPXiWgdXNKK6f5daEHJpCToFYo8E0Jaq//WnGZRjJQP0BbWlvKI3aFFdDI
	M6bPNyrqDo5Rh9Lz74xc9Yf2lzQ4ux2WpnQaf8BEADxSdckhUtZwyAEil3nw==
X-Received: by 2002:a17:903:240f:b0:2aa:f5b4:9a2e with SMTP id d9443c01a7336-2ac97445ea2mr115082885ad.11.1771261542068;
        Mon, 16 Feb 2026 09:05:42 -0800 (PST)
Received: from [192.168.0.219] ([116.206.223.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5bc8sm75640325ad.60.2026.02.16.09.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 09:05:41 -0800 (PST)
Message-ID: <c7c5a458-ec8b-457f-893d-1c4b147ebb65@gmail.com>
Date: Mon, 16 Feb 2026 22:35:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Subject: Wi-Fi quirk found in Dell Inspiron 5567
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-31889-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bandhanpramanik06foss@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76C171468A1
X-Rspamd-Action: no action

Hello,

I messaged regarding Dell Inspiron 5567 earlier. This is regarding the 
QCA9377 chips placed on these devices.

I fixed the issue using "pcie_aspm=off", and I can say that the ASPM 
configs of the Wi-Fi chip might be problematic on this device.

The reason is that *these laptops run Wi-Fi erratically if we don't turn 
off the ASPM*. The result is the overwriting of the dmesg ring buffer 
within seconds of boot and IRQ #16 being turned off for the influx of 
multiple correctable errors, which hampers the touchpads too.

What are your thoughts on turning off this device's ASPM by default? I 
will be happy to provide any details as needed.

Bandhan



