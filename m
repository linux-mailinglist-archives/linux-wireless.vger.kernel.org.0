Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164BC78EF72
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 16:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbjHaOSd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjHaOSc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 10:18:32 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B0E0
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P6Udv99X0OKznK65U+kCijFLwrQucl3E++TwmIGf3ak=; b=Ytk8frNCKnmkAIO/waddPtge/H
        y6xhhJECQpo/BdQWUM28GMulqXXi4dEcTJUhdd/Ov1+mqvrDfP+P0k9iILpx4KKZ+dSRNxRDRMlC9
        /wMwNxBFN4L1QsSt9pp8JmphnkRcQt/7N3Oc8PF6YXNhKr/P29S9eMyVcy4sLMSDPV/cOns7Hn0Mv
        +GlHuU1pClyvS8x1BbRLBwqoY5JZjXGS9ajabp8OKjLVhVA2EuA9Nxt0SBB1qHr9yfgB8bS7W+MVL
        QFyRholiZpYNICzgoAM5dAlQciBr94dj1WO/3/eUaS64pd5u/I56bY6rMrHcIzMs06mZeGlREttXa
        7yYqtzHQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51164)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbiUY-0002vk-2j;
        Thu, 31 Aug 2023 15:17:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbiUS-0006rU-Q0; Thu, 31 Aug 2023 15:17:44 +0100
Date:   Thu, 31 Aug 2023 15:17:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     gregory.greenman@intel.com, kvalo@kernel.org,
        briannorris@chromium.org, nbd@nbd.name, lorenzo@kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, avraham.stern@intel.com,
        johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        trix@redhat.com, dmantipov@yandex.ru,
        christophe.jaillet@wanadoo.fr, yangyang@marvell.com,
        linville@tuxdriver.com, rramesh@marvell.com, akarwar@marvell.com,
        nishants@marvell.com, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 0/3] wifi: Fix the NULL vs IS_ERR() bugs for
 debugfs_create_dir()
Message-ID: <ZPChCNLPMQiRrVU5@shell.armlinux.org.uk>
References: <20230831141347.3166988-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831141347.3166988-1-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 31, 2023 at 10:13:44PM +0800, Jinjie Ruan wrote:
> Since debugfs_create_dir() returns ERR_PTR and never return NULL, So use
> IS_ERR() to check it instead of checking NULL.

It is preferred that the return value from debugfs functions is _not_
checked.

See for example:

https://lore.kernel.org/linux-arm-kernel/20180601111004.1670-3-gregkh@linuxfoundation.org/T/

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
