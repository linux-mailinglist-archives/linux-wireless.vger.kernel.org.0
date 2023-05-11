Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC88E6FFD74
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 01:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbjEKXpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 19:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKXpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 19:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1B4EC5
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 16:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CF0161B10
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 23:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8F1C433EF;
        Thu, 11 May 2023 23:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683848714;
        bh=mi+RppI1xPmKTuMJIR8MHZyivO+TPEPXVXYn9BuiJNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YOsg8sLbAEyqUi+M6RiOL9dwZTneV6pqytvd9+LLW/w0jNoQKFYVtTaxgqn1uq5R/
         skEg0rUpjI6zE/3Te/f0C7cldLtjFrMperZoQ2pyMHQ3OzmKmm2k0+6VavA3TRtvwC
         bS3pUeQN88xDrZkEurhFV5VmUsowHg7AxYaebgC4t/JlNux75NugxSOwRVYvQdM+2t
         aw8aD1mH23rwAgOB+52XxEQBSPS9t6+dih2EaX9C6kEc7EF/VNYFlF3emepng2Y7La
         fFugA0gmN0y1N0j58bwNRC1UiRGA2VVDlvY54uINV5mI605myzMBPtEkMVL+CevGmC
         UWmFefNtyGJGQ==
Date:   Thu, 11 May 2023 16:45:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, kvalo@kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: exclude wireless drivers from netdev
Message-ID: <20230511164512.0cbf3940@kernel.org>
In-Reply-To: <639C8EA4-1F6E-42BE-8F04-E4A753A6EFFC@holtmann.org>
References: <20230511160310.979113-1-kuba@kernel.org>
        <639C8EA4-1F6E-42BE-8F04-E4A753A6EFFC@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 11 May 2023 18:50:15 +0200 Marcel Holtmann wrote:
> I didn=E2=80=99t know such an option existed,

Same, I was looking for something unrelated in MAINTAINERS yesterday:
https://lore.kernel.org/all/20230511020204.910178-1-kuba@kernel.org/
and I noticed the X: entries in Documentation :)

> can we do the same for Bluetooth?

SG, I'll give folks a couple of days to object to this one,=20
and it goes thru send a similar one for Bluetooth.
