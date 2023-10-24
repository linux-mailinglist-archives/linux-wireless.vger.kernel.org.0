Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8E7D5C9C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 22:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbjJXUwM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 16:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344067AbjJXUwL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 16:52:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D29E5
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 13:52:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D617EC433C7;
        Tue, 24 Oct 2023 20:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698180730;
        bh=aQp1F2otzR+yr4CFoWGp/MeWGiQzu/fU52OX8xAthKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hnZxLEWu1oSLQz0KEFizxiMmvFMiBdppyMayB+hI+LOjq5lHB2UW7DWUnVdJFuTZv
         NsqcAKhY6xzMdmWgQkkphc2TObmzSzyUtnzDWrwkjjFue/kNzanH+bqmIUx4JZsPiE
         VrRlmhgBzRKQdcQf3g5CiXnRAt3F19LtoldB7WWiIWBNkeUBNvFok3rRIcr8cw7iOd
         d90yB/AUWHEJcVhcw/s0wD+J4OCdzcVxzlpHR057Eb0OxVH1ZiGyNwTeliBxbK9ECL
         SJ7mnBJQHikFoC6Qw0mrKO1Q7mJrPsDriKQLQ2Hti8yJ6tK/DphXC7Auv6wCIXIVBM
         EztVvyAKGJXqA==
Date:   Tue, 24 Oct 2023 13:52:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-2023-10-24
Message-ID: <20231024135208.3e40b69a@kernel.org>
In-Reply-To: <1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
References: <20231024103540.19198-2-johannes@sipsolutions.net>
        <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
        <1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 24 Oct 2023 22:25:18 +0200 Johannes Berg wrote:
> Are you planning to merge net into net-next really soon for some reason?

Submitting on Wed did cross my mind, but there's no solid plan.
Unless that changes, Paolo will submit net on Thursday, EU time.
And we'll cross-merge once Linux pulls. 

> If not, I can resolve this conflict and we'll include it in the next
> (and last) wireless-next pull request, which will be going out Thursday
> morning (Europe time.)

Sounds good! But do you need to do the resolution to put something 
on top? Otherwise we can deal with the conflict when pulling.
