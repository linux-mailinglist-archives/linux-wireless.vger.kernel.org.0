Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D611A2422
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2020 16:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDHOgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Apr 2020 10:36:36 -0400
Received: from mout.perfora.net ([74.208.4.196]:46279 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgDHOgg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Apr 2020 10:36:36 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 10:36:36 EDT
Received: from [192.168.0.152] ([151.127.53.97]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MLvf0-1jNJn31g20-007lQT;
 Wed, 08 Apr 2020 16:31:21 +0200
Subject: Re: [PATCH v3 2/2] mac80211: Allow deleting stations in ibss mode to
 reset their state
To:     Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Nicolas Cavallari <cavallar@lri.fr>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.com>
References: <20200305135754.12094-1-cavallar@lri.fr>
 <20200305135754.12094-2-cavallar@lri.fr>
 <bc2934fe-ee0b-c593-e866-692487e06d4e@ncentric.com>
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Message-ID: <ff459a4c-9bf8-30e9-a486-86d171640e79@green-communications.fr>
Date:   Wed, 8 Apr 2020 16:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bc2934fe-ee0b-c593-e866-692487e06d4e@ncentric.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vyv6EJoe9Qjig7g+hKLutWeeYutIurfqt/LbSpVIauCAEsg12o0
 fBwfDpCc+NHj61m6czZsLi1HOuFYjMy2XD71QLbFv9sQgfJSnNCCtT9BQgjaVld43o/Wvyu
 q0N0wrgdMCvAwUJ5kw3CEUCyI0bFgOG1NLj9/j7S0w3r+MEaUV0IK63EFXVYMovxY1waAd5
 BWkLv8c1j9Wjp2kTU55pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T+cJ72JEElA=:3lCq5CMz6Gjw301p01KJao
 PZ6V3Ljn/MmV/hDiLNT78QSESxblufNK1Uy38QLzvFwqmXT0gjU4w5QQlswbChioJoqm6/fkH
 zDj5Loz/Su48CAtqADe0UQ3JsfssjPYPSlXDTa8jEQAq1l1mtNDhlPiQ3Z1BersUq9wyYNDOh
 qg38HNVmV79Ok+fDROkCN4lW5zeXyheHVXN1J7ww7PZxUanwnd0xDi+m2vc1YXVS5yXAtbNKc
 eA7fOA4F7VlFU9ism37aDkhbFiq0osUCjLWfyZncGZSigd2lFODrDDcqN2+423FS1NRroSnkJ
 t4d44+4Kjedl+GztYrqcEkEulPpvUWlBnZ+TCQSv1cvMWxnudBQ2ifTTTm8g3JmgqDw7WqlEl
 9EmXzokiNqVTiy/6DbG8NJpqkLnqkebParG9RQwrXlKM1jkWYrd2BuOpp3aybVA0Jf1Qt4PrM
 9lSXeQMpU0cW8o35DRhajAo8oUrMLq89AymBv0h1XhHc7LDm9FODii6c0iJcQFZDu8IvZFJLC
 MbrN9b3QkyGtNoK16vnsjMhoHGcEpbNZkhd+2jgSdsVGBBvfgve1eknelY0tFSxHBMlNZjGq+
 8zxRIMj8j6VCjVNirMcEGUz4gJ0Jy8+F8yoY3aXf8ZQUMiqiiy32qigDmiebXF1y/g0eMlSvG
 1z7Ipkd1ZnpP2cjHhgRkoyPZnW+xQbtJ2kEvAP7ndVWt1FPTch115OzwqKHGpfUycdHILWLtz
 LFeNZZTFADL/mgdt6/RvOARETFoaq4Jr/Bw4NR4YxWZky3fEqsdpo1A9UkZvSsPaYnH0P1wEL
 WdTTUnqoIxJDVz9XNHxRjvN6hntjbFNgF7Hf884Jhf9xpCzFkWqNlqFl4xN1cHl/+Lfzxezln
 aEoaTUz5K0pmECn5Y17wC4cDDTh69T3C6cPJY7ABIhSfBU5ful5zt5+7wF8kuN27z3qNarikX
 lbNy2xpaRVEokEk0DxX8Hk7WPtYo4SEcw1pd5o61ZoREKxwi2jGeD
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/04/2020 13:56, Koen Vandeputte wrote:
> Quick test setup overview:
> 
> - Device mounted on top of a vessel, sailing around in windfarms.
> - Lots of turbines are equiped with 4x 90deg sectors
> - 802.11n HT40 2x2 custom mesh over IBSS, using Dynack
> - As the vessel moves around,  IBSS links are continuously dropped and
> re-added throughout the field
> - Output of my app, fyi:  https://pastebin.com/raw/vtZSwHC9
> 
> I've made 2 identical builds, one containing your patches and one without.
> 
> When your patches are used:
> 
> --> On devices with multiple radio's, all radio's went deaf within a few
> minutes without any notice in logs.
> 
> --> Only a reboot solved the issue but everything goes deaf again within
> a few minutes. (after dropping/adding some links)
> 
> 
> Any idea?

I would highly suspect the hasty wpa_supplicant patch more than the
kernel patches.

I suppose you don't have any wpa_supplicant verbose logs ? (with the -dd
option).

I don't have physical access to any hardware given the current crisis,
but if you could tell which kernel and wpa_supplicant version you
applied the patch on, and whether you took the patches from the mailing
list or from git including the cleanup patches.

Also, which driver/card did you use ? I mainly tested this with ath9k
with ar93xx.
