Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D8250CA05
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 14:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiDWMsg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiDWMse (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 08:48:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E9D7651
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 05:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BE70610AB
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 12:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D9EC385A0;
        Sat, 23 Apr 2022 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650717933;
        bh=WvGgcNvTdW7LwS1+hnElSWv7TSlOHdmonW9LByg+bCI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EbREtjiw7t4qiziZNU6wBeOrDNmOIpdsFP0ZUp0oIKJ6wnpun8a7S6tzUj3RljZ6N
         vHIel7SIJpufMrPUEJg6vHWojUKYXbT0zqM6MSPji+d8celO7ycNG6ThclAnXrlPrD
         XF8OGxYet9trIeWyciNpnRbZd059MO8Sn7XbfeADSQupBUSHyl5RAH4dSghkMnyNXt
         dzFWWOVHDBW44TV5Iq1BccvUP5Nf2HJFUlLXVZr/3d0tThkj2kCp11pojYgzHs2fNr
         Bb2awbo2HDH+7V4s3cg3goppCVKBQc9bpNEIxYjemeC7DlQS6ItidnXsUigEkp54my
         HndGxeBnlQtFw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/12] rtw89: 8852c: add BB and RF parameters tables
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220414062027.62638-2-pkshih@realtek.com>
References: <20220414062027.62638-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165071793056.1434.7468947072709963461.kvalo@kernel.org>
Date:   Sat, 23 Apr 2022 12:45:32 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> These parameters are used to initialize BB and RF hardware when we are
> going to bring up interface and start to transmit and receive.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patches applied to wireless-next.git, thanks.

eefad995c242 rtw89: 8852c: add BB and RF parameters tables
342475ac510a rtw89: 8852c: add TX power by rate and limit tables
c6badab206d5 rtw89: 8852c: add TX power track tables
c7845551bf66 rtw89: 8852c: phy: configure TSSI bandedge
cc99eefa61f0 rtw89: 8852c: add BB initial and reset functions
e885871ee809 rtw89: 8852c: support bb gain info
e6b17cbd34e3 rtw89: 8852c: add efuse gain offset parser
7b9c98c7a484 rtw89: 8852c: add HFC parameters
bb865ba6ea83 rtw89: 8852c: add set channel function of RF part
63fb5c981590 rtw89: 8852c: set channel of MAC part
1b00e9236a71 rtw89: 8852c: add set channel of BB part
79dafcd4ff6f rtw89: 8852c: add help function of set channel

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220414062027.62638-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

