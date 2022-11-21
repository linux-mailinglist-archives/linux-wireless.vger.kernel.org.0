Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD46328F6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 17:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiKUQFn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 11:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKUQFm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 11:05:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61602D32A8
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 08:05:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1CC060EDA
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 16:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B29C433D6;
        Mon, 21 Nov 2022 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669046740;
        bh=cZKwI0YkaSZwvC4VTPcQ3VPK2nyjTWeKb2yJZfRFW/k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Dp0uZr0f0uhO4CZl7V9NrzglL4Gjnrm059i0GBrGnSa1gIzLL2yiLKDq1tQiZJLWh
         Qd/juO1ealtqWcT5zXrD6hnfwHxcrvZ83KbTg29qFgVuqWjB30z1TDIQ05VFdePa7O
         G3ER6eEqN+Ywf/V1KM5EP2W+mzDYLCZYy4FbUpIcu3NBmx4rUywMq4UaddDcoIxtI6
         SnpOCRzJqjUPOckv65Nq8QWCVHt+BrNmnks7tUdckwikLBz+yWJx8b5rJds163HIgX
         YmdvFtNC2FADV5KC3mz6meHj/MXyBFvs6umxX7IlKt6MuFYGgx25/+Kc611pfF9xRT
         60oll8xa1esqQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Ilan Peer <ilan.peer@intel.com>
Subject: Re: [PATCH 1/9] wifi: iwlwifi: mvm: Advertise EHT capabilities
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
        <20221120185147.73b38ef7c70a.I214005645f3da21d8f2458a70355deeca04a19e8@changeid>
Date:   Mon, 21 Nov 2022 18:05:34 +0200
In-Reply-To: <20221120185147.73b38ef7c70a.I214005645f3da21d8f2458a70355deeca04a19e8@changeid>
        (gregory greenman's message of "Sun, 20 Nov 2022 19:00:31 +0200")
Message-ID: <87wn7o8f8x.fsf@kernel.org>
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
> Add support for advertising EHT capabilities is supported by
> device SKU and not disabled by module parameters.

I'm not really understanding what the commit log is saying, some cleanup
would be nice.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
