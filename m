Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84B527F1F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbiEPIDG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 04:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbiEPIDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 04:03:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5FC2D1D9
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2tDRA8eK4645V9UkT0yXkIBzM/JFLxX0x/OiYBLVdPM=;
        t=1652688178; x=1653897778; b=TTLjHyUwZv4sMNp7gP4qA/HaLua4V4ttyDFjsrFj5iUXjyp
        xa0fD5zVSmIHlkZy28o3cjUp4dD5Yg2EJcpfio6aLfmzw5twi3GGU2MX1TZqY8TCu5140e09k/jUg
        Ptu8zIxhk9zzoo/vFcKCr2STVSNA6L6guKtTuRc2K3dxj9kjKyldyU67ZYYnYkzLK1hfglnSredqm
        foHg0otzmIyGtdi2UiO4+4u4Fv+S9doS73MV5Lc5qYNvRuHUqxe0bFOQAjpTgQYT1VrsQT9RpMltd
        IyGO2bGqeH+F9Er9xFbOjalBz7iNjbESb76Vq1+7DiE0pZ3MPj3Tp9SbGy0xfZ1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nqVgu-00DHy9-Fa;
        Mon, 16 May 2022 10:02:56 +0200
Message-ID: <a86cae34b3b60ab60bc8c456812e7a115f192e56.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: add support for 6 GHz channels and regulatory
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Wen Gong <wgong@codeaurora.org>
Date:   Mon, 16 May 2022 10:02:55 +0200
In-Reply-To: <1638775571-24366-1-git-send-email-quic_adisi@quicinc.com>
References: <1638775571-24366-1-git-send-email-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, 2021-12-06 at 12:56 +0530, Aditya Kumar Singh wrote:
> 6 GHz introduces various power modes of operation. Currently,
> based on the power mode, channel's psd value as well as
> channel disabled flag can change. For single interface, current
> implementaion works just fine. But for multi-interfaces, for
> example AP-STA concurrency, two different channel needs to be
> maintained. This is because, STA power mode also depends on the
> AP's power mode it is going to associate with. Hence, psd value
> and channel disabled flag might vary. In this case, same channel
> can not be used for both AP and STA.


So ... you correctly point out that we need to deal with multiple
interface scenarios.

But we had a previous/ongoing discussion:
https://lore.kernel.org/linux-wireless/20210928085211.26186-1-wgong@codeaur=
ora.org/

> Hence, this patch adds support to store all possible 6 GHz
> channels according to power mode as well as add API
> support for getting chan/freq info from the new struct
> ieee80211_6ghz_channel.
>=20

FWIW, I'm not sure that it's a good idea to have separate channel
structs? Wouldn't it make more sense to have each channel store separate
relevant information regarding the power?


I think you and Wen should go work together and figure out the story as
you think it should be - I don't have a lot of opinion on it, and thus
I'm not sure it's reasonable to ask me to figure out all the different
things.

Please work together and come up with a coherent story of how to handle
this, hopefully including multi-interface scenarios and maybe regulatory
database, internal data structures, etc.

johannes
