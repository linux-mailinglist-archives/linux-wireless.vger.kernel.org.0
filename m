Return-Path: <linux-wireless+bounces-33366-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO7aBY33uWkMQAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33366-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:53:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC2F2B4B8D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F136305DD6B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06320B810;
	Wed, 18 Mar 2026 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="jk52mHr/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816912AEF5
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795204; cv=none; b=k8elvUVONyoX/+aEV5HEkoitKc9Y56LSRZIYyxQY+8gVoAjTAlVi+0m/RWwAP2pJVTPx2oQtb4v9K6N1LSo2TSXhFr7NMZmxhVsWUGIA4IDygoYPkkVPLRQN4X1OgFpz6xakxbGDZRRPh3fZJAP1h6V3907XcfOO0B7eK6BMo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795204; c=relaxed/simple;
	bh=vKRjWMQNCxTAezrSH8HsoqRVsJfkECYcmwqxW/Aj8Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scctXMlsdBxxDFp4seVrU7isut4vpzFCPcbJL+lhxqCB0ZekUwzssFL6+W0nocO+4GZ1YU/+cg1ZauJnh3fLXrtRYEUY7PQah431Bp12G2qRz8Sk6iQX0HABNky9SlMA+CgkFmFemsUKB7lohNEMMj0+pYfcLMrCwJPnx0fPlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=jk52mHr/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7413a0e5a0so579862a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 17:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773795203; x=1774400003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WW7jK2GQPckG+qnwmykLsFF8MdG5oTYuXZfi/B2lx0Q=;
        b=jk52mHr/YZIhAcGTgJxwe3VZw3PbCrB6PJSgGWsdE8xNoDuTq1hVdssbgpyvJlSLa5
         ttUrJUZdgpUg+eFn1+JSL4GqEnC07allOaVHSKLTlYVSK3SPYR9Be4oB13HsVqr+syF/
         fMBFrfgCuc3IG8OrhjQIv72sxn9MkfJmmfQ0+Yaky8k3ng1i8hrZXUX3fQ8YGfgY6TXk
         TVZjiqe9aN3dvz1yjyFZXkxDP0QNoN/uGbL1tjApeRXqZOMHklqigpUgwDg0WBmccdl1
         LU08CMDHt9Vkf7HTy0rUPNhA5P9WbA0bup5Z4GjKmqsIl/10A+8SCrgf2hwlvWJ1gJg8
         AGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773795203; x=1774400003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW7jK2GQPckG+qnwmykLsFF8MdG5oTYuXZfi/B2lx0Q=;
        b=D850e+0eOmTrnC7RYhHQ7OZwhGeD9itubSjus2K5IC+7VARr3sSx5lp7h1QWpHpFxB
         By1J10fujFdLxjjQVtHZR0C5XjbI19aqCwpRBh10UOWq/LSkmnpBbeJ1hlwmwbIFhytm
         AtrU5Tk8ZMD6SB5HPEEmoOv8o3ZJj7JipM4nvOSze7KMR3fExFXq8A4X+a96aNiEKYm5
         c6g+KcnTY8ZCW7/gDaWfcJ+5u2/lHKe+vR3lR8txjeF9SWdwYtMNsrVqAxu301yHxL+E
         HvVPCMKIsrZws9ESzmSybn8Laot0HF1fshI6tPwLCVD/Un9VCAqt8K4FTCIoOf6Q05Em
         8DGA==
X-Forwarded-Encrypted: i=1; AJvYcCV/+AHgume4P10KtTXuNFHWaaKwjaq2U0HLgpjJfMHR1hCNNckJijO6Vpe4XbQSq4bR7S0vGEOX3eZp6al33Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwK+whrNh614KSErPHo/64UWTddjOrnB7W/8k/VxDhuDf/C0Z/
	QbZja+CSty/iJpMSzcmcIXfyoVQeXhXDSPXVEYWVfs57H3B9qgkPT0h4sHpZUBfxCkA=
X-Gm-Gg: ATEYQzyO3DA29gq/yZoSLgISJjyERYLwj37AIDvrc3bZrTN45RCj6ksfwRuaPSsZCWk
	1m/0a/vnQHQQP1JUmoqdh9832UPLh+QCCxfYIJGP5MVPwhVPnJz9VxEOsKHidiYKZLbk70baAMF
	HG919Z0ZYTw6wwtGp4RIqh5xE0WWHL4sx31hn497aIe/+Zhq0SsLL1Xp5g0jaLgOBD9+nU6XzSh
	1GyJH7IDxnUdxbZU77UHZkFc8LolY9WVOaAsYXqjU4wFXaFE+Rbnh/gPVNfywixYPKr6fuFm6X1
	Oy3gdnDK4z4SRGBR+S6fm8c+nIzyJAthCxQ60VX81gJuQQBGCi+WrU/4U8SQdZPLuHsGpS7092o
	ixOeMjn1eRJV/azIRilV4q1P7iQOSSV5gSCR+E7jdgrqk4+59Bx2edzHT3aVciWejE9sHef0VBm
	0LsTQev5qIdX01l+egs5J3cndaBXmF3sVzXP4robjq0J7Z9zZXPyul40Kv1T0nq/HtL08WKqUvj
	sDscB6Ay3htCi9kYOaRIg==
X-Received: by 2002:a05:6a21:6111:b0:398:c351:aa0f with SMTP id adf61e73a8af0-39b99d92725mr1107520637.22.1773795202945;
        Tue, 17 Mar 2026 17:53:22 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e5694acsm730394a12.24.2026.03.17.17.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 17:53:22 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:53:19 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: syzbot <syzbot+d9f5fabbbcf4b377d01f@syzkaller.appspotmail.com>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] WARNING in cfg80211_chandef_create
Message-ID: <tffrshs5h76cfj3k6lelrx6lmm7qtc7hww7r554xtnhfnsw2ip@dqktqrq2k47q>
References: <69b992c2.050a0220.248e02.0132.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b992c2.050a0220.248e02.0132.GAE@google.com>
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33366-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,d9f5fabbbcf4b377d01f];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5AC2F2B4B8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> HEAD commit:    b84a0ebe421c Add linux-next specific files for 20260313

I think this didn't have your fix already?

lachlan

