Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D137E10F903
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 08:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLCHja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 02:39:30 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:60966
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbfLCHja (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 02:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575358769;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=a2D4wM666fr/+jCNeFoZ47rprr1qoCyHM6VCgoEhS1U=;
        b=ZqD4L2VsRT7sxT4imN/KnHhs2HWX4z6ecZvewRt6MXkqYKokPVnAbodMCXKgIni0
        lPYz1My03EsPmN5DYc6H/I1Kz0c2Mmz2XyQlnMOVyJfw2+QsvFgradudhYw60Zkw8fe
        m41WCezQczuMOejc7ol8ZEfTxo75NTfcdTXRTVFY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575358769;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=a2D4wM666fr/+jCNeFoZ47rprr1qoCyHM6VCgoEhS1U=;
        b=YcrCogGPoUkhv2khtfS5rW6CpSeCXwgZuCZbrEYxgRwHLlNJysvoNFDjQN1/gYHG
        6rrFtB3LvZ5ezJUU+vPdteK6mauUImSDVAUKsas1vSFVkFqEx+Z766tSDSEjxhPeSsz
        nGOWKIIWMIPjAZ8bBpq6/6zsByxEzCpqTPwmynlc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AC81C447AE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v1.2] Revert "iwlwifi: assign directly to iwl_trans->cfg in QuZ detection"
References: <alpine.DEB.2.21.999.1912010127330.108936@department-of-alchemy.mit.edu>
        <alpine.DEB.2.21.999.1912021653360.21300@department-of-alchemy.mit.edu>
        <alpine.DEB.2.21.999.1912021706060.21300@department-of-alchemy.mit.edu>
Date:   Tue, 3 Dec 2019 07:39:28 +0000
In-Reply-To: <alpine.DEB.2.21.999.1912021706060.21300@department-of-alchemy.mit.edu>
        (Anders Kaseorg's message of "Mon, 2 Dec 2019 17:09:20 -0500 (EST)")
Message-ID: <0101016ecab326d1-88123857-cf37-47ab-b452-13658625364c-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.03-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

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
> ---
> [Nope it was more than just format=flowed damage. This one should be
> better for real.]

This is nitpicking but as a general comment I would prefer to use simple
version numbering v2, v3 and so on. Trying to sort v1.2 in a script is
awful. So calling this version v3 is very much preferred, it's not like
we are running out of numbers :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
