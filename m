Return-Path: <linux-wireless+bounces-24175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FACADC288
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6695B3B632A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AE239E61;
	Tue, 17 Jun 2025 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="uK6QdXUu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90C28BAAD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142707; cv=none; b=lwvUumejt1AVlfvsTdawrFGcf2obOr3iP/txIQh0EeNI/xyDL5a5O3j1lGK2OtjFh5a7PnDcLhX4QFjrDZxBH7ONxohqUbIsqOz4MN//GMhTEq8Sz/iFAKYaZ8zDFgTSn+ELp+nWIIBj6LmDcrz2+sHqgRR8SRi69p23trD64kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142707; c=relaxed/simple;
	bh=DmsFAMmtpwmVgGx0Je0RRiWM3vNYCnbSc2OP4t62jY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/PV38fQzDhFO3uhZMNycbiMKS0i5MBLIiP6TSCBGGW5/keJECW7PI0UHRUfsHbDnGWWSZuV8t/1DO32q+Kwl94PJ9yXASdGfmdvmG22fqSvBrH2VbBAJYWL0MuIwXI66Pgy+EU+ysav1OCPmpokAzLtGmSl/nI3dvTSoHagHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=uK6QdXUu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311a6236effso4409560a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1750142705; x=1750747505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPhKJcx1HOF+kVcJCSO2cUU7Mi6rJoKJ/MYl26SUTME=;
        b=uK6QdXUuHMHCIN/ZKWR6DA9RZJWuwtdkcBIaR5HLmErigFo0/gcp/x7cSVVPUHhnye
         64ZKXvcHR3I0tS5CMIMXSzSZEgHNQEnGdG9oAjTOfTVDnKEp6BcAkqkupFy8jUs0U7CO
         T9O7NcVkUXel2YdmyPMvzAWQj3ubykrqbbZ38n5tvO4kwnby0vYzkyJpcqMuJ0V1SdSE
         LKEznsMQRo0jXYDfU3dd92tqE25NLhZTv5Rf8xiWFZCoHysWhb7MWRSDJkQFEDva/TxR
         00NAL+SUlwc2C7VNoiNW8dcxjaIBvxGBOv7A93Xbrw6uLWPrdtmz6exi5p4Q3y/7H08s
         xlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750142705; x=1750747505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPhKJcx1HOF+kVcJCSO2cUU7Mi6rJoKJ/MYl26SUTME=;
        b=K8ww/d/d2EU5Rl9T60W0Y4/3U3kqN8mjByHSHorbFte2w65yumP572mgpTTT29eBy1
         C1YU0PELIhanaoFE8uUx4iI+7yWP1E8648o6qPvjaBwro39E9cncFsvRgJzFt4NU6dun
         QxsyaOIEY08/0sbcjxay5C+lOg0N1gy/GTcEwRz9epheCEpkBGzjG3ZGDEcbsLwftqUS
         aJ8uvguF2wOR1PloTwDZgjql0mJkm6cdAt27K9eXW3Bf7x3czxMzzj/yN4Otux815ly6
         4vRxh4WzCk0YWzkCofwAS8KehZ/XIrtT2pkUM4MwGFhvI6OQX4OU+RLnMUNb28POQPci
         ITKA==
X-Forwarded-Encrypted: i=1; AJvYcCXUiLM2D98VDDdPRmRF6JNRN2Wwn1LbRa40ZOKvQF5ft3FsWDWunS7mGrh3nQ3TLjgEsXz1A8bOqm0i4iifyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTpy5kR9iNBCt+/xIelRaMwVfdHBq3+9vvMIRJVhBQLC+v1/g
	aUt3CUUoJHwy0cP/UgonuhpkzGYzxvI86BjchV/RUzyXtcGh1EVsrEM9foiAc3yUWeQ=
X-Gm-Gg: ASbGncsQydvK1BoN137O2ixUMp3ScysXskNGP0XQbzYpVpS+rBsRDWGgEKTr3nQ2lBO
	g5ExVDaWy0rQhKb/940Hxun8mZUZfIGiJJjjyuccm033W3CJ7dH3sn23v7rfDIkNVdU6zumEc51
	QyrxK2IzVPjpa5Em92dPJxjM+8kmnV2doFixrlQNfv8essohsMHMjhpJ6/lAO0X/TXerU/gPy9H
	lGlLa4QR2orS6ZTyTTA6KvYtXh8u8e6TBNT3e0ezvT+qqP0VT9slbkaYZPjM6SfsmwpToZx+DlQ
	8P/BTUBpoZs42ecqFxXGZHmULRoSd8Qjicxm/nRR2Q5fJ8cjGER71ykZ5U/hp+0neCLZk8Q8yg7
	Yo5BXEQfBQEp7Og5nC5B9Y/fvHHw=
X-Google-Smtp-Source: AGHT+IEATTpuKdcXig3oDT5wGm1UAKIfH7oDvB2ZRnI/l3M4zOj0TS7tCEQdOdxUzUi1sdk/zyE10g==
X-Received: by 2002:a17:90b:2fd0:b0:313:33ca:3b8b with SMTP id 98e67ed59e1d1-313f1cc4bfcmr21367380a91.9.1750142704951;
        Mon, 16 Jun 2025 23:45:04 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb887csm72372915ad.192.2025.06.16.23.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 23:45:04 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:45:02 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com, 
	johannes@sipsolutions.net, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: mac80211: fix oob in ieee80211_rx_mgmt_beacon
Message-ID: <7cgt3pqpucb6glnmvjzymfisc23i5lcnc5vulaxfenkfe7tqmh@epuecpytt4sf>
References: <68504add.a70a0220.395abc.01e7.GAE@google.com>
 <tencent_8DCFF079526DB42E796E5095C0E8E2EE1E0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8DCFF079526DB42E796E5095C0E8E2EE1E0A@qq.com>

On Tue, Jun 17, 2025 at 12:41:33PM +0800, Edward Adam Davis wrote:
> According to ieee80211_s1g_optional_len(), it can be clearly seen that the
> maximum size of variable is 4 and it is an array. Based on the above, the
> parsing of the frame control field and optional field is optimized.

Hi,

This is incorrect according to IEEE80211-2024 9.3.4.3. In addition, the 
undefined behaviour reported by the bot due to using zero length arrays
rather then variable length arrays already has a patch submitted by
Johanes - please see:

Link: https://patchwork.kernel.org/project/linux-wireless/patch/20250614003037.a3e82e882251.I2e8b58e56ff2a9f8b06c66f036578b7c1d4e4685@changeid/

lachlan

