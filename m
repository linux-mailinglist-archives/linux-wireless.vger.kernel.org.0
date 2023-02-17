Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430F69A833
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 10:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBQJfM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 04:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBQJfL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 04:35:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE995CF34
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 01:35:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D649BB829AB
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA5AC433EF;
        Fri, 17 Feb 2023 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676626505;
        bh=WvfXq0mL/b300E427ERghvhPQ2+srhplPhqddnWHjcg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nPUSlQzMn8lpOP/YI8PTBh/wCKXf4AFbc0fqEo+eKOPVEkHBj7y+VUmNkRvGHZHGp
         PUPqQ7Q2t4UtvezK4OfgB9PJEzBSYIp/ahXKD9HNGTK9A5C4zMJ5AYBnbbwW4FCkE9
         HNSEH6/ONn3TmnclSObKODM1YzuCKSXo5hSego9DLKoO+ey+UwDyJZ+FWKU8uwkgF8
         zg5WfVsdKeZmYRkoUXQhXVkZIvZ++LLb2Bg61gQMAMqsbs+ofVqAlqQWqR75nshcEW
         Nugy+2imavtxtS2UYb3FpvgIXzWMCrpcQNNZKUpDpE+jH3bCDHqlXsLSNCnfeCx8gk
         Xe7FAs08yG8LA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: iwlwifi: mvm: remove unused iwl_dbgfs_is_match()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230216205754.d500dcc2e90c.Id87df297263f86b5bba002f7cbb387abc13adf53@changeid>
References: <20230216205754.d500dcc2e90c.Id87df297263f86b5bba002f7cbb387abc13adf53@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167662650309.23451.17873610622686244039.kvalo@kernel.org>
Date:   Fri, 17 Feb 2023 09:35:04 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> This inline function is unused, remove it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless-next.git, thanks.

d9fcf94b8f68 wifi: iwlwifi: mvm: remove unused iwl_dbgfs_is_match()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230216205754.d500dcc2e90c.Id87df297263f86b5bba002f7cbb387abc13adf53@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

