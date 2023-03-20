Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D496C1E11
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 18:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjCTRdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjCTRd3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 13:33:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833782C66F
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 10:29:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso17184193pjb.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679333310;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HGGv9i5SqQhPeVLQl7XFwMBB4Y//OxKsNM+BHuTlas8=;
        b=ZBEawW1wSpHzkK8/HS+Ri6QL65omkw6EFPifZrsWKp5WXg92lnowD26XisLziOhwVZ
         2nEdzI2mGrGQQwM7ELifU6FvVl6g1xVYtgfF/WvXKD6ZxdtzyCiGqWQpbRJG1FgdKH4D
         /3yms1mYL70RTGYRWZDBqjX+9WFMl/GoOmpjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333310;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGGv9i5SqQhPeVLQl7XFwMBB4Y//OxKsNM+BHuTlas8=;
        b=nbRQiHrLKiQkQtaH5L3uHR4Q9EA/yDq1NuaoYlfhw+WrzIjMuRIWtT7bV7OzXkg0iS
         gJ9uZMcCw4A6xparCaFYHHKrBUC3zor7hCrcTNxzalQEnyLTwqmf96JnjbN/WvzOFWif
         /kuGPC/6YkFsqPSjujqTs1DtLuK2PjdAXCfQ8WbVYOnGftZ3xXWywFEQ/I7Qh90dZ19r
         zpI3Ovw1FJjIMfuolF5qSYR3bAnNgIQm4Lv8DUcJ3MWDoZbv1PYR/TC889fSgrkrTAZj
         OJRTK0BsQf+DqiWhqfvCbQzNP3//3a/lv+RXTMr/M5HuatVUb/AeeuLtA6Qw7FMm7Lfj
         9jGg==
X-Gm-Message-State: AO0yUKVFCQJxUmhDLhwuReeGu9dWmuxWp+SWfRPRMu9p8Pr9DloH/z+m
        i5l4YmhvqPGhmHjDMYPXbCvcFA==
X-Google-Smtp-Source: AK7set/ayPZk2u7OUUu1P2u2+Ohp9OuSPCNnu536DGSZrZvrFnAYMWMrktDkKv+SC9Ao+lvASsuOhA==
X-Received: by 2002:a05:6a20:3b86:b0:d9:5c2f:99cb with SMTP id b6-20020a056a203b8600b000d95c2f99cbmr5279833pzh.33.1679333310589;
        Mon, 20 Mar 2023 10:28:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j10-20020a63fc0a000000b00503000f0492sm6305291pgi.14.2023.03.20.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:28:29 -0700 (PDT)
Message-ID: <641897bd.630a0220.174d9.9d11@mx.google.com>
X-Google-Original-Message-ID: <202303201024.@keescook>
Date:   Mon, 20 Mar 2023 10:28:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        lukasz.wojnilowicz@gmail.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: dvm: Add struct_group for struct
 iwl_keyinfo keys
References: <20230218191056.never.374-kees@kernel.org>
 <3181a89b49e571883525172a7773b12f046e8b09.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3181a89b49e571883525172a7773b12f046e8b09.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Feb 19, 2023 at 04:12:05PM +0100, Johannes Berg wrote:
> On Sat, 2023-02-18 at 11:11 -0800, Kees Cook wrote:
> > 
> >  	case WLAN_CIPHER_SUITE_CCMP:
> >  		key_flags |= STA_KEY_FLG_CCMP;
> > -		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
> > +		memcpy(&sta_cmd.key.keys, keyconf->key, keyconf->keylen);
> 
> This should be fine though, only up to 16 bytes for CCMP.
> 
> >  	case WLAN_CIPHER_SUITE_TKIP:
> >  		key_flags |= STA_KEY_FLG_TKIP;
> >  		sta_cmd.key.tkip_rx_tsc_byte2 = tkip_iv32;
> >  		for (i = 0; i < 5; i++)
> >  			sta_cmd.key.tkip_rx_ttak[i] = cpu_to_le16(tkip_p1k[i]);
> > -		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
> > +		memcpy(&sta_cmd.key.keys, keyconf->key, keyconf->keylen);
> 
> And that's actually a bug, we should've copied only 16 bytes, I guess.
> DVM didn't support MIC offload anyway (at least the way Linux uses the
> firmware, though I thought it doesn't at all), so we don't need the MIC
> RX/TX keys in there, but anyway the sequence counter values are not part
> of the key material on the host.
> 
> I don't think I have a machine now to test this with (nor a TKIP AP, of
> course, but that could be changed) - but I suspect that since we
> actually calculate the TTAK above, we might not even need this memcpy()
> at all?

It's the latter that is triggered in the real world, though. See the
referenced URL and also now on bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217214
i.e.: drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1103

So keyconf->keylen is coming in as 32. If this is a bug, I'm not sure
where/how to fix it.

Perhaps this patch can be taken as-is, and a WARN_ON added for the >16
case to be tracked down separately?

-- 
Kees Cook
