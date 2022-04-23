Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F150C7D3
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 08:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiDWGhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 02:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDWGhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 02:37:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE78020F
        for <linux-wireless@vger.kernel.org>; Fri, 22 Apr 2022 23:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A5D1B8013B
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 06:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94C7C385A5;
        Sat, 23 Apr 2022 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650695650;
        bh=1JLHGRs61Dtx1dRPrGOsFqdP6vKkFsyBF+yfqwAcYpE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tdFHD80DjUEyGlrfse5fu3IueQu9Vwd+QRTEEN4WclEtmDw1f3GWTxScUInUWfAFS
         mNwKPtAvsPBFad5fbtiBKWeYF+Xg0MhMvWWU0qttfjB1m7Z1quYGk9Poe9Gvktfo/I
         VeWvrx+zqIP86HYVhHVuFkA9sTJ23U4kI+2DtNJloib2gOM9IYF05ty7PhyG13cND0
         6tTUwV72QRFknTKpD6UVr/kE04lFJCl296NaDtgH1KEQeBsT5Fk1BnsTrQ2dF59yqO
         lnAisKmeec3HFMsTrCMUpKwWtGj/dOFnHI0+Ydh0fy9dL2f2oGZ3Ha8hGKJZWX07m2
         rn3q1S/IA+rQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: update iwlwifi driver maintainer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220412190141.4543-1-gregory.greenman@intel.com>
References: <20220412190141.4543-1-gregory.greenman@intel.com>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, luca@coelho.fi,
        luciano.coelho@intel.com, linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165069564680.20094.14449217728110926301.kvalo@kernel.org>
Date:   Sat, 23 Apr 2022 06:34:08 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

gregory.greenman@intel.com wrote:

> From: Gregory Greenman <gregory.greenman@intel.com>
> 
> Set myself as a maintainer of iwlwifi driver as Luca is
> moving to a new role.
> 
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> Acked-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless.git, thanks.

4dd4e6f65985 MAINTAINERS: update iwlwifi driver maintainer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220412190141.4543-1-gregory.greenman@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

