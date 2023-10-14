Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE97C92C2
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 06:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjJNEee (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Oct 2023 00:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjJNEed (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Oct 2023 00:34:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6969BC0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 21:34:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D68C433C8;
        Sat, 14 Oct 2023 04:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697258071;
        bh=HftUUtIkijf/eDpOMEaVF0swh66yC36oCv8/rd5v7vE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=M3F9+P3dnAVcR1YyEfy/FQg3DG4A1NZTZ/FuBgL9fgdZ4J2L9zHN4fwl9+HHMXYiF
         7V/2+AfZ5iiax70lyYDVixvgAzX6mQ5mPxT7Fiz4fkdEofJHSt6IkaW2QSflZDdzR/
         s5AB6Pdn48h35IzsM2Mw5xcqVr4ZRK8oLg6rmDq14peXywqYZYEI7F+Rxi9XtVpoqU
         GNOVA9uKu5KD38eDqgFFhM1MX1cvgA1trxNG6BXGGdNmykWME12jzWzC37hW99Ost8
         Xylc8anLQbGKXxePgCEtmgyZ7q6EqPvD9571t8/JSQqrdhCFJ8AnDDu2s1zxIhNHWB
         hBBsf3TcHYxjA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     gregory.greenman@intel.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/16] wifi: iwlwifi: updates intended for v6.6 2023-08-30
References: <20230830083104.546619-1-gregory.greenman@intel.com>
        <b6b3cf6c-2c5b-fd54-e550-af8ef705214d@candelatech.com>
Date:   Sat, 14 Oct 2023 07:37:06 +0300
In-Reply-To: <b6b3cf6c-2c5b-fd54-e550-af8ef705214d@candelatech.com> (Ben
        Greear's message of "Fri, 13 Oct 2023 16:46:33 -0700")
Message-ID: <87v8b9es5p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 8/30/23 01:30, gregory.greenman@intel.com wrote:
>> From: Gregory Greenman <gregory.greenman@intel.com>
>> Hi,
>> This patch set includes iwlwifi patches intended for v6.6.
>
> From what I can tell, this series didn't get into 6.6.  Is that expected?

The merge window for v6.6 opened on Aug 27th and these patches were
submitted on Aug 30th. The patches should be submitted well in advance
before the merge window opens to make it to that release.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
