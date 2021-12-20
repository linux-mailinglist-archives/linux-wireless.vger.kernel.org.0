Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0B47B303
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 19:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbhLTSlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 13:41:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53096 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbhLTSlp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 13:41:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33096612A8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 18:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE29BC36AE8;
        Mon, 20 Dec 2021 18:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640025704;
        bh=y3tKkCdRua/UjtGIT3DesNCgK7f75ov7Wut2/OFGey0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XLP0NIMColOtqhv1uKt7CiB/7an81HYoOjX5BJ6K4UF8ZQEbFiKR98Nzpk864O9CS
         4ALVue+ddhfuBFiTjG6Ds9CiFmDlcrLrV8a8/xoUAWs3lefN/rG1ZtPmudRtf1slys
         RBdIw6k+7F8lnirkqhAo5wd5T8+K6FV9y+7OaA32OZeI39DGhznXjKBbIbS+T8pLLS
         MNEgzkku3HzkOzDxFuuW1sxz0lf3XmQRaShHRcnr6ggdQMbVpbBMPFy1EwauVhl1C5
         XruuhNnptUh/Ljj5cptT/WWdw/sex1ApAIEtqwE63sxXcOkaOmfZeL1P7B/93/wDdz
         +HmybVGSeJ1hg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] iwlwifi: mei: fix W=1 warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <iwlwifi.20211219110000.1ef2bb24771c.I6a59ad2d64f719d3e27398951c8f1b678b0b1092@changeid>
References: <iwlwifi.20211219110000.1ef2bb24771c.I6a59ad2d64f719d3e27398951c8f1b678b0b1092@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164002570215.16553.15153995532804423577.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 18:41:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are a few warnings due to kernel-doc not understanding
> the constructs the way they're done here, fix them.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

4 patches applied to wireless-drivers-next.git, thanks.

991bbbeccc24 iwlwifi: mei: fix W=1 warnings
80cba44ff61b iwlwifi: mvm: add missing min_size to kernel-doc
ab2c42618ab9 iwlwifi: mvm: add dbg_time_point to debugfs
97c0979d0d72 iwlwifi: mvm: fix imbalanced locking in iwl_mvm_start_get_nvm()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20211219110000.1ef2bb24771c.I6a59ad2d64f719d3e27398951c8f1b678b0b1092@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

