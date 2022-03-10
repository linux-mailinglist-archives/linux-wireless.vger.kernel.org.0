Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F914D4EF8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbiCJQYo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 11:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244043AbiCJQY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 11:24:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D7198D30;
        Thu, 10 Mar 2022 08:21:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAC54B826CC;
        Thu, 10 Mar 2022 16:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01466C340E8;
        Thu, 10 Mar 2022 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646929302;
        bh=F3SkVcuJ03j6kXCZcX5KCUMuq9mM7z/9UBCQqJJ35WQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HAjqaPQFc4918FSP8BlW/Uh3CPqVidx2sxytoe0N39ihLjnSlE1bo46UDSVPdAooG
         PGAz/kLEigZXly2ulqZBJq9gdmbuHL/3YVUq9TPCwyybEIsEGvJ45vxe0A3zb5a8/M
         tO1okNWxw9IOtzccRfysrmPzPBdfrogpfEnvK0r4iNlOfJvCFhwkDbYpO2pwvbAzTk
         pArmi8wVjPRQ0Qzn+caFB6jDxBiMT0stJyniOX65ICKSUroajBk6aza4GKeU7KmsTm
         oeDO4Eibmzc9KENY1SxmJtaNFem85gMoZxTpU8JUUiSJFfS3/5yZ6e8IzRf/qRDk1c
         dwoUNpXyK1jQA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: add devicetree bindings entry for mt76
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <8cbfeceef642ede408b4922c363953cb243cd87f.1646766851.git.lorenzo@kernel.org>
References: <8cbfeceef642ede408b4922c363953cb243cd87f.1646766851.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        robh@kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164692929922.6056.2430113149932916110.kvalo@kernel.org>
Date:   Thu, 10 Mar 2022 16:21:40 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Specify devicetree bindings entry for mt76 driver.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-next.git, thanks.

f015725fb59b MAINTAINERS: add devicetree bindings entry for mt76

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/8cbfeceef642ede408b4922c363953cb243cd87f.1646766851.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

