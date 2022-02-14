Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16904B5951
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 19:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiBNSFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 13:05:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357361AbiBNSFo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 13:05:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE6060D98
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 10:05:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 421CAB815CC
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 18:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204FEC340E9;
        Mon, 14 Feb 2022 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644861933;
        bh=XtgQd5J3eVzlB7VBXFuazOJJQn0rfF+5OIcqnKQgZ2c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PVeN82S+XjYbkCb2MT8SvMHBNeNQvmzquX+ujw2d6AN7IZoZQUYzF5YwpMeQY5GOv
         shpDajJGvLwf85RbT5e22fgR4HkWAo+hCGDXRSnmGQXsE2wRoyeCwkj9BO7aUlKlRt
         kD7/CchamGv5dZsz0CfN1k4468W37DNcWzjyH1OqsAPLPnP//cLAhDWOiepISpUyb/
         FFWNJG3ODXYjVFqxGZgM0eDV5tWXXzBoaDjXstdsFhfgIS6HSHurq1YqKPuqWLP+4K
         4W/7Yp5W7fo9VIl042W0lKQIMD2HmQvSQwhDUzWu06h7mzRxdPsnGfckBn71xcyint
         QDyTFVF+UffJw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: Add BCM43454/6 support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <CO1PR11MB47859B51BCA88613D1582EB88E2E9@CO1PR11MB4785.namprd11.prod.outlook.com>
References: <CO1PR11MB47859B51BCA88613D1582EB88E2E9@CO1PR11MB4785.namprd11.prod.outlook.com>
To:     "Zhao, Jiaqing" <jiaqing.zhao@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164486193110.6494.5971860644536705248.kvalo@kernel.org>
Date:   Mon, 14 Feb 2022 18:05:32 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Zhao, Jiaqing" <jiaqing.zhao@intel.com> wrote:

> BCM43454/6 is a variant of BCM4345 which is exactly identical to
> BCM4345/6, except the chip id is 0xa9be. This patch adds support
> for BCM43454/6 by handing it in the same way as BCM4345.
> 
> Note: when loading some specific version of BCM4345 firmware, the
> chip id may become 0x4345. This is an expected behavior, and it will
> restore to 0xa9be after power cycle.
> 
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@intel.com>

Patch applied to wireless-next.git, thanks.

ed26edf7bfd9 brcmfmac: Add BCM43454/6 support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/CO1PR11MB47859B51BCA88613D1582EB88E2E9@CO1PR11MB4785.namprd11.prod.outlook.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

