Return-Path: <linux-wireless+bounces-31662-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EkQB0qsiWndAgUAu9opvQ
	(envelope-from <linux-wireless+bounces-31662-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 10:43:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDDE10DADF
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 10:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FD6C300539F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73322344D96;
	Mon,  9 Feb 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GW8kKK3m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF154258CDF
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630215; cv=none; b=e+qIKpJ2ZEJBZ61du8diOQjaCR/d7xzDZXBxfCzNRAjtpxf9bIl4mGGnBxDPSG5y8SwVjvkfUO0LUpgNa0gTRkLy6/XD1ah9INrtAM3WFk5KyXFUM2Fb/SFbwl2ByYWWOISi2i/m1j72FokqJ7q7EQwYj/GLRFfldyqforxF3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630215; c=relaxed/simple;
	bh=k1i4nuR9KeYyXDvuDtGmxEe0IOnujiCQewffJ6/Acgw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GUSIqP7FGoQ1B9f2Wle13ZnyGkMvZKattzwOgVjXWjzccR0eIS0jdzWpzXpuF49+7N8w4yqksmLV0SQlr2nVlIq12bZIu5xugJKq7SnNv9CGdpqiUTkf3aM+TbSjIgzAquB3k71WFnNGy4ytYixo+yOHBbXK94ZZY7BpyQN4V6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GW8kKK3m; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so60139605e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770630213; x=1771235013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iemc3OhYLX4Ss0SNWeweajTG7TrJs45B5HIXkG661k=;
        b=GW8kKK3miPedevgrJ8W2nad5wO5/rurRwsBQFUxmqFSdJb0rILWEma3FPKjUOzM8w3
         lr3LQaBF3j1reDyO8oRNeD3NhkgwTYWhkGp2rawSrlyhacLNW9hJA0f/8hyB8q+SvpuN
         7dPpbqUyXPI3oAUKTVUVEm1YVzcl/RBdhFmcxzpNGvHEeOzbYmUoU0SVNbfcgQ1rIFEp
         qImNw49SRp/moyFtRCZYYzp2RtFVxuHwBHbI6V5uF98/z4uDdg6Z+I5V/ae3Cu3apZWH
         pWZR5uoJCrKriQ6mVE36EERXSDsPCLQ6iQF8wP9O2GqCXJdlMNxaG3JnZY6TR+KGiBox
         S4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630213; x=1771235013;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iemc3OhYLX4Ss0SNWeweajTG7TrJs45B5HIXkG661k=;
        b=KcVBhS3w5M9kJA6elDXq0OKGLJZCuFgA2xhTgNwd2T1R+HvSJeEdLEWqctJjY49654
         Yon48gWkU/P2mx0kZwNAosaICJw6MFcLuOKi0/N5z8qAW/ZfPXE+D0ctBCeLtwjXltLP
         Ai7pqhMhwWmoA4oc7DR0wHZ1G7FZeoy7rHLF8uR39fFBDB2yBzvGW6J5cuvrD+gvAg+S
         BEuupA881QvYJbSHW9ee+Nm3rLMRWjrP5uDb1LIwbXdK0fD6Luf52tTNId9yJOntWqTB
         q4l45ArxJqmVYjPMTKyTFKki2l8qTWo+6G79G21zjdEOzh0TWJCpe6kU2bkodDd5/OHo
         v3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUP5lW0LXMo4gbBmYgw3doF7XpBwB9phWPzpCoS//6CvxT+F7FPJsR6qgbRbN+799UPfpyyDrM82Bqhm0c+hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNOijF4MNuuy2fIT00k/rIvMmVxmzY8YMBkrT534F6CYkCbq8
	eWdM3/Qtg9Yzmj2xX21gGiZSMlQnuXraGD0Uk7dlKcYsv9+Jt9LUoQN2Xfm88FdiSZc=
X-Gm-Gg: AZuq6aIKwKz3pgb4OdItCrbRVycBGS+kNjo1VUNzb9yDdGKpSe5m+tP5x+/yUimjEOJ
	m2P2xH8tLL3dIdyDUTY4pG48YK0jemUGAYp4fnc3W2ltcZ4MREZbHSM1ECI/P/5ZiX88KoEFpuq
	2EQiRGdX5OnS9PdT8pM2/gAUirIHgN1nd7qk5cryOXbltsHmlZByzN+H8DQ77c+9VISILKtxoL+
	GXpxeMBzof06c0lfvCfLTrcq6k6IifgHz++iemO/DA3E/Oqg+tlvfmCAcxBS4ZNls3JQrmAcdfH
	BxicCZC10spj0nYWE2mAwwHqTP10uaVQQ8FeiDOMK04lAzQV+y9HENX1PuT7ZhcIsjGR4C9IXGY
	f4lIzpwbgw8TUiVRPCLkmurUj7TXzc1jUxIlbocej11T+n25yf/1n4jWGWWm10YRKUpGaM5N+kv
	qVH29vFF/tjFhcul17
X-Received: by 2002:a05:600c:4585:b0:480:20f1:7abd with SMTP id 5b1f17b1804b1-4832022100dmr144036935e9.31.1770630213215;
        Mon, 09 Feb 2026 01:43:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c12d74sm153248765e9.2.2026.02.09.01.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:43:32 -0800 (PST)
Date: Mon, 9 Feb 2026 12:43:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] wifi: mwifiex: Allocate dev name earlier for interface
 workqueue name
Message-ID: <aYmsQfujoAe5qO02@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31662-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim,stanley.mountain:mid]
X-Rspamd-Queue-Id: 8CDDE10DADF
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding. #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Chen-Yu Tsai,

Commit 7bab5bdb81e3 ("wifi: mwifiex: Allocate dev name earlier for
interface workqueue name") from Jan 7, 2026 (linux-next), leads to
the following Smatch static checker warning:

	drivers/net/wireless/marvell/mwifiex/cfg80211.c:3214 mwifiex_add_virtual_intf()
	warn: passing positive error code '(-23)-(-22),(-12),1-64' to 'ERR_PTR'

drivers/net/wireless/marvell/mwifiex/cfg80211.c
  3147  
  3148          SET_NETDEV_DEV(dev, adapter->dev);
  3149  
  3150          ret = dev_alloc_name(dev, name);
  3151          if (ret)
  3152                  goto err_alloc_name;

The dev_alloc_name() function can return 1-64 if the name has a "%d" in
it.  None of the other nine callers use the positive returns.  The only
thing it does is cause a crash here.  We should probably fix
dev_alloc_name() as well as changing this to if (ret < 0) {.

  3153  
  3154          priv->dfs_cac_workqueue = alloc_workqueue("MWIFIEX_DFS_CAC-%s",
  3155                                                    WQ_HIGHPRI |
  3156                                                    WQ_MEM_RECLAIM |
  3157                                                    WQ_UNBOUND, 0, dev->name);
  3158          if (!priv->dfs_cac_workqueue) {
  3159                  mwifiex_dbg(adapter, ERROR, "cannot alloc DFS CAC queue\n");
  3160                  ret = -ENOMEM;
  3161                  goto err_alloc_cac;
  3162          }
  3163  

regards,
dan carpenter

