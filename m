Return-Path: <linux-wireless+bounces-14757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F3D9B725D
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 03:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A649B20EFF
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F96F06A;
	Thu, 31 Oct 2024 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GOr8QYFE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A048127B56;
	Thu, 31 Oct 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340246; cv=none; b=CfN5eAy+JcEfC0eZrs1MqCOfiPW4x8J2QTgVvDdbT3ZnSNiFFvw+ZN3ZmEIpJGbrye+sLXPzFR4zuFSnLPTnyiYK5XXhE5gfRImqmcvdssMYbXFYpCSKY8u6ddySY4FyB6el3rk9P3RD/6bHxkL8kgnByX5L696s+MWLs6tNcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340246; c=relaxed/simple;
	bh=coOSyXg6EbQFCWH/PFmV5fJm1pNJUz/lixQd5SpBsfc=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=qBVOIpROiThWpy+8qmvvOp97QD5meIuOaafSl6EzWb+BTwLEjpQ/LsCj+QrpLgr+so4dQZu5wWhPTINtRqnl+I5WhGNhyRhx1kbyFeOfVQy6SUN6uMSpBQ4Rs9QjxYhpEQxy7yfsldss2gFY8SgKh8kG2+BhFUHMCsGFaKce/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GOr8QYFE; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1730340232;
	bh=nz1VeNJmnk+dwVzkTdHNGyLZrMjSHNKwznA5lELwHJw=;
	h=Date:From:To:Cc:Subject;
	b=GOr8QYFEn+3YgjI/Z8b6nkXKiWk0lf7bMoN9w4+O37OUF7gQKEQZHmCHD7qAj1/wz
	 UOD1c1rFzO+iHqbLMbZcujUb4mVyvtpnP6DhjUpKqfxECHy42c7dK4CKpJnxxwynCO
	 CeeCnkwCShESIIlIFlUfX9anRN3NAUHQBmno3bnM=
Received: from localhost ([223.70.160.239])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id B948C40E; Thu, 31 Oct 2024 09:46:20 +0800
X-QQ-mid: xmsmtpt1730339180t1d1olfe9
Message-ID: <tencent_2C31282B61589DFCC908B3831384D569440A@qq.com>
X-QQ-XMAILINFO: Ne8lhFKlu2UFrwnzn+3o0cr+KNLAKnNNbHOcTH/lsB/1JprnO622QlW010NUAt
	 qCLxaf5yYFPUanMunJajzaAgMkRP9yEtr8h7PkyBog4kNcZfwQWdJweaMtL7qSktN8omnsf5kjyd
	 dOYwJHQuh4hGXluaPqkJ9YDqMrdMFZwjNKMFpKm5GGlBloEA+XiLwgaMDD1srWjcSl05Ov5OtpLG
	 qdGOVb8vXu2JZw8fffTXivAoVBbiRHkBPfXrh0htHF4DHn8ARX1v8azUyHQq57fuYH3RMjRLhbFB
	 0C6kYDyRV/kJ8U56tadjH196dck4Wv3t9MjN9krzFkw8bB/M1oYh8gRpSZekA4M1i9rtLw09+4OF
	 MdHz7MU9PCEWYERQN+KoZ3bdh1oEZbi1FBbEF5Sql71dUmTCpuP7rnrH2LTK/w2snPGq1EfOE/S5
	 WawfTt4EYjaKDFskB0XbeJ+YYE74rLa107isAf9PPt4rbrjwAYoeumyXDUBwxx/LQ+h0paez47wP
	 VTXh0Zqx26AQf90lVmyiV/MvRuL9ADpuseLbLQttmyYkDfWc+GVznKaGl6MpOGhtstkJGjxva38y
	 NnwmxfO3MW3V/BGDnUAkAlRw2Xwlu9BtJBS23aIf6aUAFhuo/87J66HgNhiBOu8v31ZlLkwY/M/H
	 +6ApiTdweq9N4nCEY9qbnj+YY3GOBoSeE7VluyMTdlhbVZvbinHnL6HB4gXm3gtfoVRDUHMHuxty
	 VJ1EQfnUJm3aObkKxd4LMa1KKyP2B5A1HRBWECFRA8m3lp2IkJlgXVhDtnqjIvMDy/HtoYXwXMIP
	 NsZI3SyDb8BXekZMsFaz+gqP0GrSPSJgHIaaSKoL23ZW5ZMiy1fOeAARciVVY5P4kfP4vFQk7u6x
	 bLw5VufRroQJ5eCHHTep6KaZcnLe5MOzglw2w32vPBa1UyDkygubnPQDc11tgWxpjM44qbs757P0
	 ajTEKAjyGRlU1heaQksQ0sWHA2SubtT2uHuZbQppAVUj2zS4yMBNpcxdXE9jemVsppQtRJpAtBqz
	 VDXe2FZw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Date: Thu, 31 Oct 2024 09:46:20 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Issue with iwlwifi Firmware Loading When Compiled into the Kernel
X-OQ-MSGID: <ZyLhbA2t-oiQZnpL@yangang-TM1701>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Dear Maintainer,

Recently, I met an issue that I would like to bring to your attention and 
seek your expertise on.

When I compile the iwlwifi driver directly into the kernel by setting 
[CONFIG_IWLWIFI=y], I encounter an error message stating, "iwlwifi direct 
firmware load for iwlwifi-so-XXXX failed." However, the relevant firmware 
files are present in the /lib/firmware directory.

Based on my observations, I suspect that when iwlwifi is compiled into the 
kernel, it attempts to load the firmware before the /lib/firmware directory
mounted. Consequently, the firmware cannot be found. Once the filesystem is
 mounted, iwlwifi does not attempt to reload the firmware.

To address this issue, I have considered two potential solutions:

1、Modify the Driver Code: Implement a mechanism, such as delayed_work, to 
give iwlwifi another chance to load the firmware after the filesystem has 
been mounted. This would involve adding additional logic to the driver to 
handle retries for firmware loading.

2、Modify the Kconfig: Change the configuration to allow iwlwifi to be 
compiled only as a module [CONFIG_IWLWIFI=m]. This way, the module can be 
loaded after the filesystem is fully mounted, ensuring that the firmware
 can be found and loaded successfully.

From my perspective, unless there are compelling reasons to pursue the first
option, I would recommend implementing the second solution. It seems more 
straightforward and avoids potential complications that might arise from 
modifying the driver's core functionality.

I would greatly appreciate your insights on whether my understanding of the
issue is correct and whether such modifications are deemed necessary. 

Thank you for your time and consideration.

Best regards,

Gang Yan


