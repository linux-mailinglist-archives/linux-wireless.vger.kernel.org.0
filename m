Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A2461F4C8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiKGN7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 08:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKGN7s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 08:59:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C3B23
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 05:59:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j15so16343987wrq.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Nov 2022 05:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLRE2IBTL6tXQElQll3pK2nkKzxcUu8aFfReYTDtJOA=;
        b=FERxbpSxvJWObig+KC/olDuIrKt66020ifjSl9RS1RTy8qNPia6NSLrMFFn9sCtm8w
         kqcgOm287QqXZ8NhD5QBi09/SagXXxcspAI0N77LpkwD4YthSbEFBLUrS58VF0tBEjst
         1AE+o5nuPNdL7zUPAodJSvaLrAjK/cA53eWCc5LGEcrBEh3JIPTEeXMB5CqT4q2dUPB8
         Q/bgOTj4Vd4nJjjTAR4rgqN9QmDWwP05zHFXLiCc/A+v1QPMeuxb0hXlmGtbVCg6OcYN
         Ql+NhKNOmY4Ol61xwpIh9FUrWgop5s3tIQwmTfGJ/2mINF+u00orQQw6xz03AY5NwUKq
         zmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLRE2IBTL6tXQElQll3pK2nkKzxcUu8aFfReYTDtJOA=;
        b=Xmb29VrbrYVCU7Ab63ExZ7ojDyql+AAiEOphpDuHn2aZMSjI+iyIzliMSDDiaCmPYt
         KsCuWqHtJKSOaRx3zOKJvYq0Ss1SI5a+ppqTkpkLWEbmtW01x85hzTvTwn2FeX7YMP+Y
         59cTh6ixVxieZLGFYG8Pz2PMzLow7d8Zs4BG+t56AZSflKaZDa7CfiTH9NdxgpZKLGJQ
         d3WlJi37m+xO5T7V7oedneEWX4gUp4zLDppso5UVV0hEKgfYML2vTxEPG+M72GFtL07K
         scaF85n5X9iNgnSiriIWf83Ltoa7j4Xdx0kKj1NkMLCl9+nlZfGhzgweSrjqH9q377ko
         G9Bg==
X-Gm-Message-State: ACrzQf2pC6jQD09tm0ITnHJii+rgSwPDGkN03I2kd8/0wyaNFqKF9HV4
        SzAUX8qzAWgV4HzCgR5UzOE=
X-Google-Smtp-Source: AMsMyM5meQNZVUELxa5jjGDahXbbpyEf8m2laiYNEGWKezJ6ex4ZxyyDXhvWeEf+mbYds/VWKUSD0Q==
X-Received: by 2002:a5d:49d0:0:b0:236:ba53:ec39 with SMTP id t16-20020a5d49d0000000b00236ba53ec39mr30217611wrs.412.1667829586269;
        Mon, 07 Nov 2022 05:59:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s25-20020adfa299000000b00236b2804d79sm7809977wra.2.2022.11.07.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:59:45 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:59:26 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     oe-kbuild@lists.linux.dev, linux-wireless@vger.kernel.org,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: convert PS buffering into iTXQ
Message-ID: <Y2kPPn7qmao4VL5y@kadam>
References: <202211060817.mqDPz8T7-lkp@intel.com>
 <08af0517-fb5f-cfd1-e92b-18306603144f@wetzel-home.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08af0517-fb5f-cfd1-e92b-18306603144f@wetzel-home.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 07, 2022 at 02:52:55PM +0100, Alexander Wetzel wrote:
> Hi,
> 
> On 07.11.22 09:00, Dan Carpenter wrote:
> > Hi Alexander,
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Wetzel/wifi-mac80211-convert-PS-buffering-into-iTXQ/20221101-100832
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> > patch link:    https://lore.kernel.org/r/20221031211815.6666-1-alexander%40wetzel-home.de
> > patch subject: [PATCH] wifi: mac80211: convert PS buffering into iTXQ
> > config: openrisc-randconfig-m041-20221106
> > compiler: or1k-linux-gcc (GCC) 12.1.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > 
> > New smatch warnings:
> > net/mac80211/tx.c:1145 ieee80211_get_txq() warn: variable dereferenced before check 'vif' (see line 1112)
> 
> vif can't be null here, the existing null check is not needed.
> 
> ieee80211_get_txq() is only used in ieee80211_queue_skb(). Which already
> access sdata->vif.type and sets vif to &sdata->vif prior of calling
> ieee80211_get_txq();
> 
> Would dropping the null check in line 1145 be an acceptable solution to get
> rid of this warning?
> 
> I'll then would do that in the next revision (v3) of the patch and send that
> out after either Johannes has reviewed v2 or serious issues are discovered
> by anyone.
> 

You should probably delete the NULL check in a separate patch (I say
without looking at any of your patches).

This is a Smatch warning and not a GCC warning so it's not like the NULL
check hurts anything besides readability.

regards,
dan carpenter

