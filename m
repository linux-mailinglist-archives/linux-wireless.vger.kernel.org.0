Return-Path: <linux-wireless+bounces-15185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF109C42B8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 17:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDF1B21898
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C51A0BC3;
	Mon, 11 Nov 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="QMJp5kB1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560C19C569;
	Mon, 11 Nov 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342831; cv=none; b=gDdMdNC39/Y6a2en0b1n7eWl3z8S7/p3k43JHQfaBLlA/yHspr/ipKRqEDUOH69PRNppZMKAVnAwUsGB8Xdx77DNp4pl4CAgG9cNj+Zv2al485X7OmOizyh/1wZWtjdsu7bP2H0OYRkfB4oQKnqi6SOORhTt6IS1IlPyv8TVGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342831; c=relaxed/simple;
	bh=j4uoUp5n7iREeZzZ/thaU7R9+6SG1yecMpGuq3NZFkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tM56PZnc6+ewz+KSMswFUTqOBBZgIvlwrfV8r1mywSAD5auwUGcOPogY7sVABFy22e3D0DeJppVWoo4uhsxfwY9D8oo6fUfbvLOKB+UvvJcajwK099T4hSsjvADonOm9NxsjfqXYljF9HDerrFFj1VOYfHpbtaXfg6RdegFn00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=QMJp5kB1; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 94A6A1F470586;
	Mon, 11 Nov 2024 19:33:36 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XaEUo0ZkN_6N; Mon, 11 Nov 2024 19:33:36 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 698B51F40DEAF;
	Mon, 11 Nov 2024 19:33:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 698B51F40DEAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1731342816;
	bh=j4uoUp5n7iREeZzZ/thaU7R9+6SG1yecMpGuq3NZFkY=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=QMJp5kB1ZUGda11rCd36Y/6Z2RNlFqPCMW8b1/lhqCVXrHVvvjVbv1pJUXYGJPJpo
	 IFd8HY4XyyPiW3gm9SANjJ35EaUuVx3N9r1nCMiWdKvua4qVxEJG6iz+qPuaSBBkuZ
	 zELeVGOb/loP/xJM9Gkz78MbX4+m1LxcSZXRyrAfdpuehjYa11XQAfbOwjKxCWM7XZ
	 o8ApYW6XF2w+OYGnGjIQjVB32v2bQ5tRUnCDHBl2N4RMrkSh27dk12BeYxIMdTYGgD
	 Jpw8dDECvMRJF19YrKbCaOWc5j4ccvXuS/aaNsh/LVBUY6jeQsh4mdFtuXrxYR5QZb
	 /mQHwRGb9fqPw==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2msykQDS5Cul; Mon, 11 Nov 2024 19:33:36 +0300 (MSK)
Received: from [192.168.1.103] (unknown [89.189.111.71])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 8E88F1F40DEB9;
	Mon, 11 Nov 2024 19:33:35 +0300 (MSK)
Message-ID: <be2bd888-2cc0-471c-8c68-fb9146fa1db9@rosalinux.ru>
Date: Mon, 11 Nov 2024 19:33:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: Add additional USB IDs for RTL8812BU
To: Zenm Chen <zenmchen@gmail.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, pkshih@realtek.com, rtl8821cerfe2@gmail.com,
 usbwifi2024@gmail.com
References: <57d4fa02-0b03-0a46-dc97-320fa5e5b540@rosalinux.ru>
 <20241111072643.5142-1-zenmchen@gmail.com>
From: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Content-Language: en-US
In-Reply-To: <20241111072643.5142-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


11.11.2024 10:26, Zenm Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi Mikhail,
>
> According to the guide of submitting patches [1], "Signed-off-by" can o=
nly
> be used by patch author and people handling and transporting the patch,=
 so
> Ping-Ke said he may change your s-o-b into "Reviewed-by:" or other suit=
able
> tag. We would appreciate your kind understanding.
>
> [1] https://github.com/torvalds/linux/blob/master/Documentation/process=
/submitting-patches.rst
Thanks for correction! I am totally OK with Reviewed-by.

