Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA086A69DE
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 10:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCAJg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 04:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJgY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 04:36:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D536FE3
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 01:36:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2755461284
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 09:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED20C433EF;
        Wed,  1 Mar 2023 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677663382;
        bh=Ob1sgIo2WEsYui26uhBFf4kfhpK0M5p479GyQPcI43I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Qu+iuCmCYY87FPCZ5hpZ/MQvogTyzTzuhd3NxhNX6lu4hNQL4giYU7CMkEpmWedDZ
         EK+uEhec5DJUsKTJT5POlCBbPpzUrmiZ/XfzTx794VfR7E3RBivL8HdP39hKgeJmjP
         pgQwm8uxwPOpyF4xm7iijT/+20JEU9oVykbEWBP26ePIePd5o1mBaAWYCplnceNtrA
         BK5G7QHrudJy+33Ijk1Yg6009PJseQbeebAO6bssgEYXU6uB2eA4CV6iMW15dxtu0H
         iD8Tz82UKEv7wpy+U5GgIOAhQRnDnk1r0/vDf+C0QcwWsB2LKR+0bwAzUMGzU2OAkT
         DHkj7b5MHyQ5w==
From:   Kalle Valo <kvalo@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Ilan Peer <ilan.peer@intel.com>
Subject: Re: [PATCH 01/21] wifi: nl80211: Update the documentation of NL80211_SCAN_FLAG_COLOCATED_6GHZ
References: <20230223100942.767589-1-gregory.greenman@intel.com>
        <20230223114629.92bcd37b0ba6.I5129fd61841332474693046241586f057b134c3c@changeid>
Date:   Wed, 01 Mar 2023 11:36:19 +0200
In-Reply-To: <20230223114629.92bcd37b0ba6.I5129fd61841332474693046241586f057b134c3c@changeid>
        (gregory greenman's message of "Thu, 23 Feb 2023 12:09:22 +0200")
Message-ID: <87356o24q4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

gregory.greenman@intel.com writes:

> From: Ilan Peer <ilan.peer@intel.com>
>
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>

Empty commmit logs are not nice.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
