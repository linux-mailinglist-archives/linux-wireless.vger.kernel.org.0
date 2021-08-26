Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990233F83C1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 10:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbhHZIb0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbhHZIbZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 04:31:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6DC061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xmX32MGO2AKihv8f66b1MAJsZEvCTBwLG94/AXPlyvs=;
        t=1629966638; x=1631176238; b=ROoutMauV5XtG03xNBDAX/LzCqEbrR09KrjfLFgAN/v9PZv
        f8+89AYJ+ejDfzvknY22b4UierNvN9+7m9U1DQpNt5O0r8ndbFwQ/VMbNL3KClYWS00VQjVAQwLu5
        f0nLTlDhG6xFuy7yiLEz5iAekhypq/pqIzrvTpvSzMf1K7CxtZ8lJcwuuRFE8BmRbF3l4gYPzVzml
        XdYrbahHqrhlrjX7PkTe+fHTbU6QUrTJVXz4luVVvdhY3tp0ne+3S46WwYRGP9TZXL9sejW8VZqsD
        /6RYspJ5tJZgUggCRmHIzft+fPvrW4mLg2N3kKP2cwOQvS/1yACTbXoKvldUAXMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJAmQ-00G4uU-6g; Thu, 26 Aug 2021 10:30:34 +0200
Message-ID: <ab8ec9741e01bad0857e165ca35d968e8dc9dee7.camel@sipsolutions.net>
Subject: Re: [PATCH v2 6/8] mac80211: add definition for transmit power
 envelope element
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 10:30:33 +0200
In-Reply-To: <20210820122041.12157-7-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-7-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-20 at 08:20 -0400, Wen Gong wrote:
> IEEE Std 802.11ax™-2021 have some change for transmit power envelope
> element. This patch to add the definition of it.
> 

Generally: I'm sure Kalle has some page on this, but your commit
messages could use some work - you don't need to say "this patch" for
example, that's entirely obvious :)


> 
> +/**

not actually kernel-doc, but I can fix 

> + * In "9.4.2.161 Transmit Power Envelope element" of "IEEE Std 802.11ax-2021",
> + * it show 4 types in "Table 9-275a-Maximum Transmit Power Interpretation subfield encoding".
> + * And it has 2 category for each type in "Table E-12-Regulatory Info subfield encoding in the United States".
> + * So it it totally max 8 Transmit Power Envelope element.

very long lines, will fix that too

johannes

