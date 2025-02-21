Return-Path: <linux-wireless+bounces-19255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839BA3F08B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF25189CE79
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF020459B;
	Fri, 21 Feb 2025 09:37:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D082040BF;
	Fri, 21 Feb 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130673; cv=none; b=FpAK4BgTaTULp3aBrjyNjnrd5Aw8erDTQ5bgnflNcTF2YI+u7gpXSnbWMOcwW287uNMJT6ijMoBH167hGC/w3bxOaSDEKFDQaoxBYeBHDyQm3PHiyvVQ81jpq+7Tr1LqSIr5rR215Fz7uG0mQXodjLto1o0zL/e2wvOdm866x+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130673; c=relaxed/simple;
	bh=bAeLxz+c1Ts7bphdqbep71s5QSoID+9JDJSBujnvkVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTa0lLFtgsi8EIoBsr4qMZlP4nBTQ7UNB4eylam/vuXw/g1N5GnwdaTUm6PY8IvA+9xlkkimhCviP9ldArRjopNfbDyzm+QgGhhYuVBsysyQqvBVXzp+wVj6G1LtBW7Dsw5Zwnxltg9YkGdmF/1RE9OzqtcKdGTPi6FQ1nMSmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so2546139a12.0;
        Fri, 21 Feb 2025 01:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130670; x=1740735470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fSnnglnDE4OxiijvbfYtwaf+0cH0qRVW0DkL1E6oSo=;
        b=SL6l8pTjeZhaMjbGdiCmhWn+Ujqr5Hc5eI5ywWCZwV4I2g9xfsAL+R1sJ732+/7fmw
         w1RzBLFQvwKB/Ymeq/O25hVLLIbGrWVQwh7rOyJAPLyx/uCUqhbFtDdROCS+e/Rg3QVB
         HJUZN9SmP3V3XDGh/7Yu1UrUMA/aXswRj1K5sQuv7unRAisHdCpyyK/2tKwqoTNptw24
         lh2P3RvJyhzHljM4lMYdlz0KW936esz7dqI4WWJb772gE4zb5ZxiIaMMCUyulmz1Vono
         Af194fj0LsueuajEifH+5CL4w4qtZzcFOX57vJFUKRb3KelGPB9ckmq9+bYrsJ8eVNgB
         Dkzg==
X-Forwarded-Encrypted: i=1; AJvYcCUMDNmbSrj+4FmfJPThzsoEmd2UQ9KGWf4LSw62hzur4pNKBGVv6Elb8hO1vNE4y0DUVtq1W6bnAM2KX2/Y6O8=@vger.kernel.org, AJvYcCV5W4lcc/GQ0RuaktH8pBb00uLgeoCbJtFEiX/gTrPqtNlpBj4bOVal4wn/a+Qvta9vK7efL0zw@vger.kernel.org, AJvYcCVKe6q7Mc1I6HQX2qolCFYcW0fKckr0Ap319chJ8VMSN028EI9+W3x1Hvz9WbbgRJKzKDUTWQlUBpT6gHFK@vger.kernel.org, AJvYcCXDTtBpLu4nBc6ssomFMe1eOc/lqSb7KKdzn2e94XOrkiMzNugD2vllpo2gxiI+9iMGwWzPW4Dad1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQ2NdPmlZwqHjOiXf/SI0IUG1F1ZWnq03q6tpN0H4xlSHhdmX
	Qe6gtO+G40Ln3GKLuffozuwkU/SdAbNyK9Qw/i3nBqRY8nAIzOHm
X-Gm-Gg: ASbGnctXoa5b+tP6ewtVR4btyb/IkHLaWepTqyxIt0YEOP6ekjF/XFy/UBmMs+1Z9as
	ezQ3DVb00UywEyCFNJ1sBMOLzQd0H88KadhxMwqqx5U7buBfH6XtZgCjiZH3uH4Bc0oXaluZWbp
	YFPjjijfBalF9Oo54y4yxWE2LIN0CDqpQwmbE13vSjIxxZXkPmR6fjpGoZDKu5SHLjp8OZ/yBEo
	WP9MMWUS5SxzYXHtVp1rmgxDr9+qLnmJepe5eB3InuAK3/VwQW7nHEd3wbm1Y81d9Ikv066fHoy
	LLjiBDgohSmQaFCQ
X-Google-Smtp-Source: AGHT+IHWNmEkqGtajxkcN65Dyk2qU9qs752a20orApMklK9etxurXq/hZktNRXLRI1CrjEYJmjdFLg==
X-Received: by 2002:a05:6402:50c7:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e0b70d5729mr2037533a12.11.1740130669931;
        Fri, 21 Feb 2025 01:37:49 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e07464bcc7sm6281773a12.33.2025.02.21.01.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:37:49 -0800 (PST)
Date: Fri, 21 Feb 2025 01:37:46 -0800
From: Breno Leitao <leitao@debian.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net-next v5 1/2] net, treewide: define and use
 MAC_ADDR_STR_LEN
Message-ID: <20250221-glorious-evasive-piculet-40ad13@leitao>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-1-4aeafa71debf@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-netconsole-v5-1-4aeafa71debf@purestorage.com>

On Thu, Feb 20, 2025 at 06:29:20PM -0700, Uday Shankar wrote:
> There are a few places in the tree which compute the length of the
> string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
> constant for this and use it where relevant. No functionality changes
> are expected.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

Reviwed-by: Breno Leitao <leitao@debian.org>

