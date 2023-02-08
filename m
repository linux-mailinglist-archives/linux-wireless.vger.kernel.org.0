Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8381768E869
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Feb 2023 07:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBHGiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 01:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBHGiU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 01:38:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B0330B22
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 22:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CC1614CB
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 06:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7A7C433EF;
        Wed,  8 Feb 2023 06:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675838298;
        bh=mhD/EWgGszxPsFh3WqoLAHO21oXmXSla6vlTemTi2JM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JqMKT4C9EvWY9KrjrGCZgxAG8EGkWmCMXr4/cB/9sfBuNGrdPqc1j8nz4h/Odzx2D
         e85Q1p76QPfNH4sU1WB1O6Qyh7MkmGn0aluCQIXZPuZrY+bKhJ/0Tuak9z+jkAxYK5
         acQk4wWyw6gMIj5mF6MGWPO2SAQVTYaHlrED37io0PpRr76GfAz/BWYMXEWGN+Tlvp
         voOeYRIEJg53OGunbhbKnTvWMC0dnXEkkCIlbfeZ3hqOfqd1DDp9vZRXqpRdS5p/It
         7/2lNVx/wOuLQFl5V61xJnrU66vd8ctDAP04MlCtlDH+EHRf1xengu04Pg1QG7WuQ7
         bE8S1C34UtZxw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH] wifi: mac80211: mlme: handle EHT channel puncturing
References: <20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
Date:   Wed, 08 Feb 2023 08:38:14 +0200
In-Reply-To: <20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
        (Johannes Berg's message of "Fri, 27 Jan 2023 12:39:31 +0100")
Message-ID: <87h6vw7jc9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Handle the Puncturing info received from the AP in the
> EHT Operation element in beacons.
>
> If the info is invalid:
>  - during association: disable EHT connection for the AP
>  - after association: disconnect
>
> This commit includes many (internal) bugfixes and spec
> updates various people.
>
> Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Miri's s-o-b missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
