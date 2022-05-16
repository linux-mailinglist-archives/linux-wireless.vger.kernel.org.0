Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F45289F4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 18:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiEPQMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241391AbiEPQL7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 12:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E00387B9
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 09:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B691061014
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 16:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB17C385AA;
        Mon, 16 May 2022 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652717517;
        bh=k4Z629lD4jDxAZwSbnjVJOG6WtkNWbSIW3DDKaMroFE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mgNKFxad3brHr5iIOwNJ7Ab7Rmg7MLeTJdmIYIWl/gGwMxCt1uYuZ6vjxSMEP0DQY
         O+LlzLmgR6QufLIksNzVaPY1GeZmCaR213Frou6mvFXGwkzHTqbHZh3DpvnUkxrk7v
         BJ1mBmuiCjEy4LeQyDLl6wbywnr4gD59J3zV+3ELGefJoRFICYXr8sKuzQDr4jIdGl
         VfecWhlK8AStcAju4qLErJBK57V8l4p96U/XD4fxFRByzIIavp/0FLI6vGU/klqsb0
         /AplshdL/9H1MqA8TdqSgSAZUSurqWZMP7JVDsv3obwUHJQFnI4bA31S9I4sXsscye
         LBXpVXModne6g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: fix misreported tx bandwidth for 160Mhz
References: <cd2735a40da7f4fcc5323e3fca3775e7b5402ece.camel@freebox.fr>
Date:   Mon, 16 May 2022 19:11:53 +0300
In-Reply-To: <cd2735a40da7f4fcc5323e3fca3775e7b5402ece.camel@freebox.fr>
        (Maxime Bizon's message of "Mon, 16 May 2022 17:23:43 +0200")
Message-ID: <87o7zx4fue.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maxime Bizon <mbizon@freebox.fr> writes:

> Because of this missing switch case, 160Mhz transmit was reported as
> 20Mhz, leading to wrong airtime calculation and AQL limiting max
> throughput.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

On what ath10k hardware and afirmware version did you test this? I can
add that to the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
