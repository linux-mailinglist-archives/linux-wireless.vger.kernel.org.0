Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709DB411483
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 14:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbhITMdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 08:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhITMdU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 08:33:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1013AC061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TtEnrL9SFhlteSmR8dsiYcxqVdIHhva2vcPQWNZQBds=;
        t=1632141114; x=1633350714; b=yIvCW0fW6SIGa2AqAQxJlAwU2bueeUoP1jIov/vLlNcqlG6
        bxIKhSXAIE86sKYRSbtcEgQJIwLP4sT13tWLoOaGCAjs2eZBGtx6moiIbZV9WdDG+bo+Xj4irujDN
        P5S9fofElQ2D9148MarREeP61oo5JnihO6unx5jZX1mytl/2Wkj1a2ptBxfTzPk8S+cKBg56bSN85
        V/+3ggzk5QWV+9amJR4oNpvDse08r+nnrfE+c/7ecR13WHzM74lA/1vstKQJzffNBxL47M8Uk9th6
        6gBn1CGbLuzfQjDZb8Dfkl1Z9WdVRxAbctJP2nn2S9KTHTHshpaqtesxp1HB5Otw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSISa-009Ql6-LS;
        Mon, 20 Sep 2021 14:31:48 +0200
Message-ID: <e4f49325610cae6148ad15eb823584df88f0c1ba.camel@sipsolutions.net>
Subject: Re: [PATCH mac80211] mac80211: limit mcs/nss to spec values in
 ieee80211_parse_tx_radiotap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 20 Sep 2021 14:31:47 +0200
In-Reply-To: <CAJ0CqmW1c0Zs61yF9d3QJevBenB2B9TNWLADFTpH7cBGbjhbgw@mail.gmail.com>
References: <0529e19e583be780ba2488e891c50dcfcf2ce4c1.1632128258.git.lorenzo@kernel.org>
         <e848121b-c0ee-d8e4-8f4b-dc9b64210261@broadcom.com>
         <CAJ0CqmW1c0Zs61yF9d3QJevBenB2B9TNWLADFTpH7cBGbjhbgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-09-20 at 14:20 +0200, Lorenzo Bianconi wrote:
> > 
> 
> AFAIK mcs10 and mcs11 are not part of 802.11ac standard but I am fine
> allowing them since they are already managed in the code.
> @Johannes: Do you agree?

For sure it'll still fix the warning, whether or not it's then useful
for the driver is kind of a different issue I guess, but it should be
OK.

johannes

