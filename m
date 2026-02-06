Return-Path: <linux-wireless+bounces-31613-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPjkHaKbhWmUDwQAu9opvQ
	(envelope-from <linux-wireless+bounces-31613-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 08:43:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2165FB177
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 08:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CA1630095CF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66899328623;
	Fri,  6 Feb 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoG6JLKn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95632826F
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363804; cv=none; b=qM5T5VZV0JPfS1ag5qqf5vk3TqRrz1cjFwLVdCAr8aMqqZ9wxVZUCe4/tbgIz4Cno4pOuvejp2DsKTjtLN+Ldgroy8VWxCfFnq+jrRiMHKQ/h5b9TxbHn+8pOTbAyWS2dzziV4DnyW9Tu0mZJrXWsJsk6QXyqF3ycpWvtGp8w1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363804; c=relaxed/simple;
	bh=9RjpjFedtU0Ptyh6CRoBzII0vCDL6g1Rl3WR6pG8Wvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHHNYeutfhURLCtJoz/tiL0UZZcKaj2AtHSFKTiycoXYwsCyryidz0FOipiDCYXGomNPTu0AIhtvYIn00dk376RyW3UCLMpSHlHneW4/3euxTuWOruF7Gn693h4izauqtQXkHwUGpsrl/X4eTIGPJsydUTNLeRqsaXhljuArAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoG6JLKn; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so4182735e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 23:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770363802; x=1770968602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgDuS5mG4Fz7SD1w0n25gd+R6hF8xgeHoOBsycwgKWM=;
        b=uoG6JLKnOe9qgkgL77aZz3k71iHoNHIPXZ+eidbeaouHLRsWQqQ2qo0GX9NNjJbLKu
         qMy61H9zuHUvjpFFQuav85mQj1pTjP453DHYbLbWnRQ4SCs+brDzX5XoEamUxV0BOaVC
         8mEu4Wl2CFJYiCdwjeAp4th/jQaelyh2iISVktSPHSIp6/g+42AfMvRqJ8bT7typRyrm
         un/0vx8WRDR22HjzyAlo5+PcL5fcwH/68RABoIT781xdmOHLl34hfQS9f2KmFu3d3DuD
         4SWzPHEPR4J2iujsdF/T7b85wH+RNwuShWQOP8HhCEgGWYeRA3GDz7T3wL9uHV+eF8BS
         rM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363802; x=1770968602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgDuS5mG4Fz7SD1w0n25gd+R6hF8xgeHoOBsycwgKWM=;
        b=VPLgzmtqX7rmLwLdSnMZdRaX+xqdBu+gK+h04Uxbp+1XtrcBJPrkRrqa+Vs6JQjSC3
         du08JpSeqK81+3JBYsY6M0yFCtoB0I7hc03HC7Q58O0E+TWoJzJkL27WwjLH3q0pMbGV
         u0lQsJIItEbQ0JIQD8mn70i7aPn8EBANVcV5v8GH13oj7KI32KArYjRqIUp48Vu6SvsP
         8y5eV3O7Kq/AzNE88MV0xGB0GVfXZcHa7Bi2hKIn80YebmMF7c8GOp4Lcd2J9kdQCBh4
         QJjgYX/95J1qiJNaGerQxa0ngNYJ+3D+5KSGnCR/ABU42a8sxTtI9jPcptAu0mtiDmCq
         b+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRiok2bZR7Q6zMrxvpV+faBK98JR/xosa+Y74SWW4BgdsIhTYl90dtTQcKAWme6cULAgahCvAYkGwM7AXhoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mji7ii8DLB15zaUQEzwDDVy98/FuRk5ztJK6Kudj4zKBF4hL
	K2LB2jlAJ9X9Yq8HWm0OzYE50LeBc/MXXv0C+RWOCQIjcjoDHHXYHA81JKaV07rfNuo=
X-Gm-Gg: AZuq6aK6OwYU2QYabUf8PNSlvjikh01+fPQY7mbrpaXFaWIXyftW1WyoGfoqEWiggnU
	7eBh+xm7zAc+YZdTiQkJJvE1GX8UUnOPOewGlEyG+B/N61mBey73YRiMAk0h5PZoD6dM2UwT/uT
	9S2owyDryjoFMb/tvxGG8oCQhbthKm0CBwmxVuCaffozaEB+6KfPqg9BoWP0WC4hPNVDMYh323s
	e6Z5Q/GgP6sDGh6TVTSkQnwseA/EzdoWz+V+r+OuQUiROcg6BLVhcMaiz9LASzW9LOujhKuDZpK
	c12j4hqrEriupEulrYqmrI29G6eelpP27nxQ7dcZtr0rR+sQwmuK6hThW93xK7JYqh0kq368xjQ
	Rw7SUkzpnDwMATC0KRcB/5UKQ8WitfR4DreMo11YbcHodQC3qNEIipqOuVY+EFrBtp0zqsuqEnF
	FCLVPBmgbgiVaHQX77
X-Received: by 2002:a05:600c:5489:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-4832022918dmr24764095e9.32.1770363802205;
        Thu, 05 Feb 2026 23:43:22 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206b8ebbsm51176895e9.1.2026.02.05.23.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:43:21 -0800 (PST)
Date: Fri, 6 Feb 2026 10:43:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: bubupersonal@tutamail.com
Cc: Linux Staging <linux-staging@lists.linux.dev>,
	Linux Wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw: btcoex: clean up style and documentation
Message-ID: <aYWblhoLbSYCHkwH@stanley.mountain>
References: <OkiaM3C--F-9@tutamail.com>
 <2026020541-pectin-jujitsu-0c63@gregkh>
 <OkipX2h--N-9@tutamail.com>
 <2026020533-commotion-surfacing-e9ea@gregkh>
 <OkisUHh--F-9@tutamail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OkisUHh--F-9@tutamail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31613-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tutamail.com:email,linaro.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2165FB177
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:38:06PM +0100, bubupersonal@tutamail.com wrote:
> Here's the correct patch.

Nope.  That's not a patch.

regards,
dan carpenter


