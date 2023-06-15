Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ABD7317EA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbjFOLyr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344630AbjFOLyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 07:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3F469F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 04:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F2DB63BC5
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 11:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC377C433C8;
        Thu, 15 Jun 2023 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829668;
        bh=ETjfqbV35FydXvtQT6glIanv5Nl5Ltd28mo9+pNNqaw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UpjKZs3oreG5S+ux9roaMSwCGte48DJrQnHyfkZp+9pf1J27jvZhR0P/y4ShdmyUD
         eVo3rjRKYQFsUgi0pis74aM8FYSw3wcfRNum0lSF8r0m0E8qfDJ6VUxy0qzeKtVa0D
         fE5sQzKlVkTfMActgAtT8s+lL8SNpx/IXXKCg0gFn5I3IiZk94aPq08WHcdxGQ9qvZ
         r1qBa9By2moxGPmt/Hd8qiYeEPWmVFKreVpoOmUksrVBW70fjNyawpfTDwOWrTFUy2
         H2owO5Z0Hjx7T9B2DFcM/zQ293qBo8zl+cNLeq+zlp38dqkPvleSW/W5PWwWPgI7gs
         n0J/BkqrNsmAQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 00/11] wifi: ath12k: (v4) EHT support
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
Date:   Thu, 15 Jun 2023 14:47:43 +0300
In-Reply-To: <20230602235820.23912-1-quic_alokad@quicinc.com> (Aloka Dixit's
        message of "Fri, 2 Jun 2023 16:58:09 -0700")
Message-ID: <87y1klaqw0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> Add driver support for EHT bring-up, association and
> preamble puncturing.
>
> v4: Modified patch 3 to support WCN7850.
> v3: Modified patches 6 and 9 to fix some issues,
> changelog included in the respective patches.
> v2: This version modifies only few commit descriptions,
> changelog included in the respective patches.

I did some minor changes to these patches in the pending branch, here's
a list:

* patch 3: ath12k_wmi_tlv_mac_phy_caps_ext(): remove unncessary cast and add const

* patch 3: shorten struct ath12k_wmi_mac_phy_caps_ext_params due to
  long line warning

* patch 3: improve error messages

* patch 3: move struct ath12k_fw_pdev after struct ath12k_pdev

* patch 5: ath12k_mac_get_phymode_eht(): add extra spaces, improve error messages

* patch 6: cosmetic cleanup, extra lines etc

* patch 6: ath12k_mac_set_eht_ppe_threshold(): move declarations
  to the beginning of the function

* patch 7&8: use BIT() for enum wmi_tlv_peer_flags_ext

I have two more comments which I'll send as a reply to patches. I'm
hoping to fix those in my pending branch as well so there would no need
to resend anything.

The changes are now in the pending branch, under tag
ath-pending-202306151144. Here's a link to few of those commits:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=974310a085acad9cee462b3f343e8c05185abc67

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=e4b7f51541b4ae79baa1ab9a8389fd4d9e0fe219

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=ae4b76c40bc7350d52d42de6e8633f6e52d905fb

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=3594ef351ae29788c00fad6c69d60b9a41dc1bbb

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
