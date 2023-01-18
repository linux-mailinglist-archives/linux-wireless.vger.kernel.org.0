Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5D67224E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjARQBc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjARQAE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:00:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EE74EC6
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iGKuhT8qUdQU9bkT4zASobwQHITRxrTd/34c/v2fk/A=;
        t=1674057429; x=1675267029; b=d7QEqRNjpq3x7BsyJS2cNDPYzt40xkbm/yIiVVwgtMYH+1Y
        xgSvpl9igAPoLba50JuqcOGJOeCyeMshnuh8SX9fdq4y5c6tx/kXeotDl4wXIv3s/0QrYlJxa4r3A
        d7VqpegJXETGig3fBDxQ6cSKZx2ORSL6AxFIkuUZ1ARZdWJr0HcJSEZi2YtWrVaQ8OixnivChoRyF
        aiqjUUlE3qixEnVY99LHcajEyh8bBbxasxh3JK8W/z8yuODtH/JZZTiulF3d8K7twkU0zhLuqpUn5
        JAfET8cKvHiUILn8Fa6uKULOCd4j6BwqmNFR+jFqNN+axsetRtdAvOkaPndQYFKg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIAoF-005ei9-0Q;
        Wed, 18 Jan 2023 16:57:07 +0100
Message-ID: <0b42cfb9f0effce61b33c41ec9067b3747fade5c.camel@sipsolutions.net>
Subject: Re: [PATCH v7 2/3] nl80211: additional processing in
 NL80211_CMD_SET_BEACON
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 16:57:06 +0100
In-Reply-To: <20221109214720.6097-3-quic_alokad@quicinc.com>
References: <20221109214720.6097-1-quic_alokad@quicinc.com>
         <20221109214720.6097-3-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-11-09 at 13:47 -0800, Aloka Dixit wrote:
> FILS discovery and unsolicited broadcast probe response transmissions
> are configured as part of NL80211_CMD_START_AP, however both stop
> after userspace uses the NL80211_CMD_SET_BEACON command as these
> attributes are not processed in that command.

That seems odd. Why would that *stop*? Nothing in the driver should
actually update it to _remove_ it during change_beacon()?

Are you sure you didn't mean to "just" say "however both cannot be
updated as these attributes ..."?

johannes
