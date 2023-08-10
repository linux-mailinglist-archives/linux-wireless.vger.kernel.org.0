Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61333778458
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 01:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHJXwo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 19:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHJXwn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 19:52:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C752D44
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 16:52:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc83a96067so11159415ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691711563; x=1692316363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFP7qz6oliD2INbwobgTLc91s+rnyjq9ywPTuKDl+Ng=;
        b=n/0oc6QFrfzlTLcmcFhoji19B7LnhyawU9348NY1Gpm0N3D8xruG5VJP0+XmlIaQd6
         BrfDuzjnvWmmj09UMZcNBhJ4ULsVBZoiSr+G+uXRJx2T2gX5l8Or6bbPhLrHduYYS4Rw
         wnF4oRarIaLS8d20YkENZliiFSDfZWT91kL+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691711563; x=1692316363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFP7qz6oliD2INbwobgTLc91s+rnyjq9ywPTuKDl+Ng=;
        b=S+K2RdPFjP06oU27BXMBW4yazK/vfsRvgZcZO94gPtb86V47s4rbFs3/cp8A2zZEQF
         ZRlf5ANPwHl8O46/OfUK8VB91EsRfkSuTWp7t9ICZKI+NRRc5vImCMr4CN8j2MsNQMAw
         0z7NTi+5fkjS+8hU8crCnSkZHqaOQgW3nZ4W7Oj1ck+HPpbnErmHx3wk9UEBpFjAw4NX
         klaNBhpRruRg0smTLAuKT41DgAIU5rkbVs1j3HjWJ4+OtjeDuz0x7vV7kwvrV8tlTtWb
         cq03k1gSNdyV+62oemnOs2/J0zUWjyiiOETbea3aaNL4PUV2D/Ic6vYq03w1cnE9gOvj
         oHeg==
X-Gm-Message-State: AOJu0YxhytKoZIElRMo3FxHvXWp2EXNYlgz2bQqJr24ujA+KewGsZ+Yz
        xN2IlMiEU+vOI5ElJCVJL+DX8A==
X-Google-Smtp-Source: AGHT+IF9znJEE8JKuomGipegCcB+xS8fbe0vnqtmisZ+JjPGNd+Ru2eDPr0ljclGgowEc3oV9swSrA==
X-Received: by 2002:a17:902:ec06:b0:1b8:5b13:5958 with SMTP id l6-20020a170902ec0600b001b85b135958mr255467pld.31.1691711563040;
        Thu, 10 Aug 2023 16:52:43 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4ec8:57d8:e207:3679])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e5cc00b001b80de83b10sm2361557plf.301.2023.08.10.16.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 16:52:42 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:52:40 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     johannes@sipsolutions.net, kuba@kernel.org, kvalo@kernel.org,
        matthewmwang@chromium.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Fix missed return in oob checks failed
 path
Message-ID: <ZNV4SDobJaM4pC7B@google.com>
References: <4933455600e633c8cbafc0fc3180a7023894f8c9.camel@sipsolutions.net>
 <20230810083911.3725248-1-pinkperfect2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810083911.3725248-1-pinkperfect2021@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 10, 2023 at 08:39:11AM +0000, Polaris Pi wrote:
> Add missed return in mwifiex_uap_queue_bridged_pkt and
> mwifiex_process_rx_packet.
> 
> Fixes: 119585281617 ("wifi: mwifiex: Fix OOB and integer underflow when rx packets")
> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>

Reported-by: Dmitry Antipov <dmantipov@yandex.ru>

And:

Acked-by: Brian Norris <briannorris@chromium.org>
