Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4061912BDBF
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2019 15:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL1OPq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Dec 2019 09:15:46 -0500
Received: from fold.natur.cuni.cz ([195.113.57.32]:46294 "EHLO
        fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1OPq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Dec 2019 09:15:46 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Dec 2019 09:15:45 EST
Received: from [192.168.251.10] (asus_g552vw [192.168.251.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by fold.natur.cuni.cz (Postfix) with ESMTPS id 8BB0810FCA33;
        Sat, 28 Dec 2019 15:10:11 +0100 (MET)
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
From:   Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Autocrypt: addr=mmokrejs@fold.natur.cuni.cz; prefer-encrypt=mutual; keydata=
 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
 vhAAniqNXIsAJtnhCdggmBmY0OwRUQNY
Subject: Untranslated -256 cipher codes, old iw website is gone and SSL
 certificate is wrong
Message-ID: <7f392c05-9023-49a3-022e-14c8ad0b58c5@fold.natur.cuni.cz>
Date:   Sat, 28 Dec 2019 15:10:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,
  I want to report that "iw wlp1s0 scan" (version 5.4) does not translate -256 algorithms into their descriptions but output their code:

        Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0 
        DS Parameter set: channel 100
        Country: CZ     Environment: Indoor/Outdoor
                Channels [36 - 48] @ 23 dBm
                Channels [52 - 64] @ 20 dBm
                Channels [100 - 140] @ 27 dBm
        RSN:     * Version: 1
                 * Group cipher: CCMP
                 * Pairwise ciphers: 00-0f-ac:10 00-0f-ac:9 CCMP GCMP
                 * Authentication suites: PSK PSK/SHA-256 SAE
                 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC MFP-capable (0x008c)

   I have dd-wrt and I assume I should see:

dd-wrt# grep pairwise /tmp/ath1_hostap.conf 
wpa_pairwise=CCMP CCMP-256 GCMP-256 GCMP
dd-wrt# grep wpa_key_mgmt /tmp/ath1_hostap.conf 
wpa_key_mgmt=WPA-PSK SAE WPA-PSK-SHA256 
# grep group /tmp/ath1_hostap.conf 
sae_groups=19 20 21
group_mgmt_cipher=AES-128-CMAC
wpa_group_rekey=600
#

  Moreover, https://wireless.kernel.org returns wrong certificate for a different domain and https://wireless.kernel.org/en/users/Documentation/iw returns error 404. Please get the old URLs working again so that people get redirected to current website.

Thank you, and a happy New Year,
Martin

  
