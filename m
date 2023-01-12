Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8E666E95
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 10:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbjALJrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 04:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjALJqN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 04:46:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0AF1CB0C
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 01:43:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 168D6B81D93
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 09:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8E0C433EF;
        Thu, 12 Jan 2023 09:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673516600;
        bh=wPHPEog+rdVefap+ST1BbjFo3jPs8+/NUtk79vzc7Ls=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PDsBZTK0uEqbPFb8/aGlw6nj2eGHYMeD9FhQ5xQRC/CYUYqWyPXS+ldIC6hfN7FeI
         qyLrQ7sk12s7wgtvoww8G4+iPYMKsXbeo6uxccpqZxrwgIVXdT7k8yxxrP6r3luNMp
         oibXaqNxColLZ68pmoWqFjPnB1DQhucSfOa5SoABFjEt0A6BbiC1wQQNkzzq6/SXuI
         cTJ98pcg7NrPpAT902O5ssxe+OWMGW1utZsxhFpsJgjv7rTeDua0mnAIQx3mosIBnt
         tsFiq6IEIjoZz9+IRn0YPvX35qjmWF8DnApCNULn2CIP4/rERWT9sAdNHj46p9quZ/
         HofzwnFnf7wjA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        chainofflowers <chainofflowers@posteo.net>,
        Christian Marillat <marillat@debian.org>
Subject: Re: [PATCH V2] wifi: brcmfmac: fix regression for Broadcom PCIe wifi devices
References: <20230111112419.24185-1-arend.vanspriel@broadcom.com>
        <f46ab6ff-3b2d-fbb0-9201-ba346630fbf0@broadcom.com>
Date:   Thu, 12 Jan 2023 11:43:15 +0200
In-Reply-To: <f46ab6ff-3b2d-fbb0-9201-ba346630fbf0@broadcom.com> (Arend van
        Spriel's message of "Wed, 11 Jan 2023 12:39:42 +0100")
Message-ID: <87358gdr64.fsf@kernel.org>
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

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 1/11/2023 12:24 PM, Arend van Spriel wrote:
>> A sanity check was introduced considering maximum flowrings above
>> 256 as insane and effectively aborting the device probe. This
>> resulted in regression for number of users as the value turns out
>> to be sane after all.
>
> Forgot tha mention this is for 6.2 kernel. Apparently the commit
> causing the regression was also applied to 6.1 stable tree. So this
> should go to stable as well.

Ok, I'll add cc stable.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
