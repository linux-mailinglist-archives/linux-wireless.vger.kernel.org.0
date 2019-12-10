Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1B118244
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 09:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfLJIdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 03:33:05 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:51174
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbfLJIdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 03:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575966784;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=ALLMkamNNe5NKhusqJhGG3Vs3anSBpjn51kEn0G6IxA=;
        b=I/LLZmbmaXwgK2erxDmHUf7XHugwSWg+bc68QV1xL8hx6Cp/aMKvhK1QvnwwCoYy
        08go0A3vGJGgidHGJBr9I8S/cxJwyaAiJvv1xyUstxzORHYY59OtT4PdlhHsxldICW9
        EyoZ5P08Q5tNCc+f9pdShGxtb+FiC3H0uvicnFVk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575966784;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=ALLMkamNNe5NKhusqJhGG3Vs3anSBpjn51kEn0G6IxA=;
        b=Kc7c/Q9FAqNFFLOyZIuG5hB4gmw2Lh2kOzMy4WJ6+H8QsrKM4XJcQRHe3oNFzLXF
        JOdMVG/rWL9kKnXFiiOKGSmWzDlXgNhWQz7RihCfvcv4wvSF351uoLv8VUt3StcIDUW
        hJllT7lQwJuEvU8QNzgBYODLbsromRKoLhneC7qM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0B48C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1.2] Revert "iwlwifi: assign directly to iwl_trans->cfg
 in QuZ detection"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <alpine.DEB.2.21.999.1912021706060.21300@department-of-alchemy.mit.edu>
References: <alpine.DEB.2.21.999.1912021706060.21300@department-of-alchemy.mit.edu>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eeef0b98e-9251829b-8524-4fb8-8ca2-1d084d532f94-000000@us-west-2.amazonses.com>
Date:   Tue, 10 Dec 2019 08:33:04 +0000
X-SES-Outgoing: 2019.12.10-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> wrote:

> This reverts commit 968dcfb4905245dc64d65312c0d17692fa087b99.
> 
> Both that commit and commit 809805a820c6445f7a701ded24fdc6bbc841d1e4
> attempted to fix the same bug (dead assignments to the local variable
> cfg), but they did so in incompatible ways. When they were both merged,
> independently of each other, the combination actually caused the bug to
> reappear, leading to a firmware crash on boot for some cards.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=205719
> 
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> Acked-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

db5cce1afc8d Revert "iwlwifi: assign directly to iwl_trans->cfg in QuZ detection"

-- 
https://patchwork.kernel.org/patch/11269985/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

