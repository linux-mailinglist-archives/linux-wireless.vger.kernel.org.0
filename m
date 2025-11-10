Return-Path: <linux-wireless+bounces-28785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C9DC46E82
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD68A188DAE2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02F311956;
	Mon, 10 Nov 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="iyMdcPpX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0C3112A5
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781609; cv=pass; b=sBpdO7N1a7ABooNeWiPSFJLnTDMj3Kr5n2Ii7fzMBww8CzdeyDkIxmeZDyBjfg9bMD/kFL5BH27nayDKBjymb/m/fwzgVRlQeCB7hW3U7BDxkpFbne0M9P0ktOcg6UR/zW8FU9/z3KdAYkfWhSN+cbc5fH3qktAJ/xVShucg97E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781609; c=relaxed/simple;
	bh=z13Ts/WNBisEeZN794d2JM92Q4ZJqRvBA3IDtiZBD3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrhOuqLrHccvnUnQ6D8ki0E1apycwvcHVcmT9p1+7kcGByZ+pyqcXtvNM1Zaq9VDtlJxVplSBtBQciaQioK7F0kmzz6B0bDi0XkvqodkSAG7+HxuDPZVwFDxViyswJ0QqnhRdnAVGzAcLypoCk9IjLc7V21uwjbeKO0I5yWrY8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=iyMdcPpX; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762781605; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fKzikm2YXOnGGJIj67S5/auEUMdOPFzawTLeAjSBj2mxyQWe6OotBLLxXeK0tnWyGX2gBEQvjgus5+mmaWeQSLfRpmjRkYoLeIjJwwXc7ztDG3msTZh86Zg+jYEb70GNTuMNIreY/fsuCVmXdpubOsId8hrC1yos5zUgB+vjrs4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762781605; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lbO4HjGIN8tLxaXjyr13qsvDl78i+D7jf3dzA6I+Cag=; 
	b=J94B3eib/sbhGg8y9ZycN+UVAl197pTgslOXg0enAhfyRd+7/+5rjvTIIdHCrfc1h/fhlrJ2thjxZYm6WFjKfiM7z8CBD76auTv/HxMGZGEdE5wrzENda20EYRXX6rceSLnuw/M+pJioFXd9dM+WSWpKa6/9uRKd3H1wyk92Pd4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762781605;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lbO4HjGIN8tLxaXjyr13qsvDl78i+D7jf3dzA6I+Cag=;
	b=iyMdcPpXy8qUIQRkpCLQZUzh6rDIkQLkkuKBhSB9Oz8pVxoWWXEjVl2siiedxIn0
	VZVKjmWUa4S3POgGHa5PFHc0B52MqQShbmXmtVLPadBrCRCb6vv8WCmsCekij72M6a+
	T0xoJSXWcXZuJTODQSw7MRTLileoM0myWujV4zjM=
Received: by mx.zohomail.com with SMTPS id 1762781602764202.00411538697574;
	Mon, 10 Nov 2025 05:33:22 -0800 (PST)
Message-ID: <0ed7eb21-a261-45b5-b3d2-9b9bb63d688d@xv97.com>
Date: Mon, 10 Nov 2025 21:33:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: mac80211: remove an unnecessary copy
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251109140450.118106-1-m@xv97.com>
 <20251109140450.118106-2-m@xv97.com>
 <e340d3d08e945df144110b9da2f272cab8a2c40b.camel@sipsolutions.net>
Content-Language: en-US
From: Chien Wong <m@xv97.com>
Autocrypt: addr=m@xv97.com; keydata=
 xjMEYrGw+RYJKwYBBAHaRw8BAQdAYXRqCQnACPka63iaZ2Lc9u8qPBNaxew6PdbvpuPvkIXN
 F0NoaWVuIFdvbmcgPG1AeHY5Ny5jb20+wpYEExYIAD4WIQRhWIfCT4U86RkflE5cpYo5+kEi
 rQUCYrGw+QIbAwUJEswDAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBcpYo5+kEirQtx
 AP4uJuD0ufTDXmEotuOUiI+86qWvc3jNsUhWYW8wHN8zEgD8Dli09jo/TsTlfWIXWjIs/6Pp
 b96j9fho6xNpETu8ZgnOOARisbD5EgorBgEEAZdVAQUBAQdArBbkcgnrIZ6XnmGUAA9XYA+i
 tf8afTv75UGa2c0YkwoDAQgHwn4EGBYIACYWIQRhWIfCT4U86RkflE5cpYo5+kEirQUCYrGw
 +QIbDAUJEswDAAAKCRBcpYo5+kEircrLAQC/yXFAHzoG9bnsw+hsiVfEbYMa04UiDEFkTd9Q
 kA+I2gD/VCzYkTizWTiXsbcGhB05Q+mI5tX+ehhtpcrIAaBxnA8=
In-Reply-To: <e340d3d08e945df144110b9da2f272cab8a2c40b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/10/25 3:34 PM, Johannes Berg wrote:
> On Sun, 2025-11-09 at 22:04 +0800, Chien Wong wrote:
>>
>> Compile test only.
> 
> You can trivially do better than that, say with hwsim + wlantest.

OK. I will test with hwsim and update commit message in v2.

>> Fixes: 26717828b75d ("mac80211: aes-cmac: switch to shash CMAC driver")
> 
> That seems unwarranted, it's not even broken in the old code.

Yep. It's a small optimization rather than a fix. It will be removed in v2.


