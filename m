Return-Path: <linux-wireless+bounces-407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69BF8041A4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 23:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58548B20B9A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 22:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AED3BB20;
	Mon,  4 Dec 2023 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHiBSIMt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E3C19B5
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 14:21:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c659db0ce2so2088298a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Dec 2023 14:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701728465; x=1702333265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ehtQUXwRDZKnRhPirJrr51oPYToKsRQq0IW02tneMYk=;
        b=CHiBSIMt7cCtjE0xahD6goP/Gv2seDpXWIKksbEDlzNJeAQCuE1BBt6O85BOvlICpU
         vfrZeMw6uynrOsRr1LdVB7XQd7EjPP7hw0A+NGdDKOTqPjRjcibLluM/rfLl4iNoFcV5
         r2rspn6wt0bzeTU1qwfxfnF8bWzbBo9lbzw3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728465; x=1702333265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehtQUXwRDZKnRhPirJrr51oPYToKsRQq0IW02tneMYk=;
        b=n+hBya+eazWgE2LoSnhWF78KewJcS9ng2yYR74J8KOAux7oMELOLkrrcnj5SbFY7G6
         dEecqRSpjZK6smxC6WeXh0peDxLFC+/F19aXMo07xw2JWfSEHExAMwdWgKUjXDkYQu0w
         E5UTfZY4XxwVprg+TGapd9gzZmuIz/Nzi1cCjRkl4OivwKp1mkhhrZ6I+f8UMCaYbIqn
         /8Ag9O1P4Gh3w1nZzPQktDnIqUbZjB/LYPMvCSm12qJVxz5tB4cUTWypsi4myvZH0Kdz
         e4wqBbgVt/Kgi1re8v0exrj/BBWEzk7gUGldZcE7WaDFY45JSLphnntiCAcSCarF3I/G
         0EhQ==
X-Gm-Message-State: AOJu0Yy8PQfUo1qRoUgVq7Hvi92Nqa8BJJs1Obj5HJOiW+HfcWb7+sWp
	kdA7CkPk9/ccV3AZpCvS1KnoVQ==
X-Google-Smtp-Source: AGHT+IEClAA5AROgHOJAOd4Gtv6KL71/ZWQlR+Vg9YJXC8KdewByNC/42QtAGDPVsAEKARgH/jvh5w==
X-Received: by 2002:a17:902:f544:b0:1cf:c649:529c with SMTP id h4-20020a170902f54400b001cfc649529cmr6001552plf.18.1701728465486;
        Mon, 04 Dec 2023 14:21:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902c44300b001d084f4fad5sm3707362plm.2.2023.12.04.14.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:21:04 -0800 (PST)
Date: Mon, 4 Dec 2023 14:21:04 -0800
From: Kees Cook <keescook@chromium.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Walle <mwalle@kernel.org>,
	Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] netlink: Return unsigned value for nla_len()
Message-ID: <202312041420.886C9F3@keescook>
References: <20231202202539.it.704-kees@kernel.org>
 <95924d9e-b373-40fd-993c-25b0bae55e61@6wind.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95924d9e-b373-40fd-993c-25b0bae55e61@6wind.com>

On Mon, Dec 04, 2023 at 10:22:25AM +0100, Nicolas Dichtel wrote:
> Le 02/12/2023 à 21:25, Kees Cook a écrit :
> > The return value from nla_len() is never expected to be negative, and can
> > never be more than struct nlattr::nla_len (a u16). Adjust the prototype
> > on the function. This will let GCC's value range optimization passes
> > know that the return can never be negative, and can never be larger than
> > u16. As recently discussed[1], this silences the following warning in
> > GCC 12+:
> > 
> > net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
> > net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
> > 12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 12893 |                        flex_array_size(cqm_config, rssi_thresholds,
> >       |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 12894 |                                        n_thresholds));
> >       |                                        ~~~~~~~~~~~~~~
> > 
> > A future change would be to clamp the subtraction to make sure it never
> > wraps around if nla_len is somehow less than NLA_HDRLEN, which would
> > have the additional benefit of being defensive in the face of nlattr
> > corruption or logic errors.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> > Cc: Michael Walle <mwalle@kernel.org>
> > Cc: Max Schulze <max.schulze@online.de>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-wireless@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  v2:
> >  - do not clamp return value (kuba)
> >  - adjust NLA_HDRLEN to be u16 also
> >  v1: https://lore.kernel.org/all/20231130200058.work.520-kees@kernel.org/
> > ---
> >  include/net/netlink.h        | 2 +-
> >  include/uapi/linux/netlink.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/net/netlink.h b/include/net/netlink.h
> > index 83bdf787aeee..7678a596a86b 100644
> > --- a/include/net/netlink.h
> > +++ b/include/net/netlink.h
> > @@ -1200,7 +1200,7 @@ static inline void *nla_data(const struct nlattr *nla)
> >   * nla_len - length of payload
> >   * @nla: netlink attribute
> >   */
> > -static inline int nla_len(const struct nlattr *nla)
> > +static inline u16 nla_len(const struct nlattr *nla)
> >  {
> >  	return nla->nla_len - NLA_HDRLEN;
> >  }
> > diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> > index f87aaf28a649..270feed9fd63 100644
> > --- a/include/uapi/linux/netlink.h
> > +++ b/include/uapi/linux/netlink.h
> > @@ -247,7 +247,7 @@ struct nlattr {
> >  
> >  #define NLA_ALIGNTO		4
> >  #define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
> > -#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))
> > +#define NLA_HDRLEN		((__u16) NLA_ALIGN(sizeof(struct nlattr)))
> I wonder if this may break the compilation of some userspace tools with errors
> like comparing signed and unsigned values.

Should I drop this part, then?

-- 
Kees Cook

