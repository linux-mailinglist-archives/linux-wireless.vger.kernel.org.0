Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220ED13A3C4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 10:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgANJ1z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 04:27:55 -0500
Received: from mout.perfora.net ([74.208.4.197]:56397 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANJ1z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 04:27:55 -0500
Received: from [192.168.0.152] ([151.127.53.97]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LaE7U-1jWRGy04yM-00m1Qp;
 Tue, 14 Jan 2020 10:27:50 +0100
Subject: Re: [PATCH v2 0/2] Allow userspace to reset IBSS stations to fix
 aggregation issue
To:     Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
References: <20200103103457.22778-1-nicolas.cavallari@green-communications.fr>
 <a7fac744-8894-ec2a-7d94-68f4f3f8500c@ncentric.com>
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Message-ID: <a115bed4-72de-0777-86f6-7306d9eba95a@green-communications.fr>
Date:   Tue, 14 Jan 2020 10:27:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a7fac744-8894-ec2a-7d94-68f4f3f8500c@ncentric.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oh1DwTgKmsCDWloRihLUwTp37qpiJ9fou1QZOG4DWFxpv0APx+7
 cXXfnRAtN0F4dFew/3ErwHuu9GKmZ2wY1ql3RJBLgFdBJHdazL+UPX2Ewa/q19v2Ih+Vc0a
 P4XWO0zcziEgwwBVp9HEmazkcnW0glOeFVLTzsPP+9Yf2AnjdmiVq80eZHSN/qSzmEoRGVL
 uBofAAHvfZYBysmG90cgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uCHExjcsoMw=:p/nSPnnX4WEsCo5/0G0aKw
 hzpqHunrZT3iRUF7Hv1/cTxOy98mQuzd3u9FF3BFD8brmnrLLYeehBSndvkpkXTnsygPEDBO8
 492SX5r8ZmUufNafD8Xl96BamYURx8IhINHCKEv6A4TzjxrHTlci9WLIUrlbjX5zy4aytaDvW
 ac+l0Hx8M3IVtg2qEm8Jv8d49J2hajjJT4VKwwMTX9ER8+cB7RsN6swmgnySQ1PU/2+x2zDu5
 VPdg93bZ/uShTRGiCUYISC8Bxr8xAEir3e4QmrbGm8ZgLVshnsV+BrcKAbleUBqFx/TCLILS6
 iLTbUbE6/On3fugMuqZp5TSraY8hX9ilWJQslKSuITV6+fGmjKV77Xuq+bFgEbxyaaqhR96lH
 cI3cHFiyGsgRTyXpD1fGAyXN5kQeTTaoRBPTb1mkHcpTNEV9VCPcXw9ABfi6M0aB0m62l/yaE
 kGltUMZxnmimPrCZbyy6ApEZmMAULAhH+KoRG808pnW3y15Zla+7hVWMtwkmrL1cxkP9diExq
 W0QalDJQZEokHGuzs81gkU5c1NtkUuqLCfPgcI30K2QwTFin2Teb6LV5LbvUrQpkuwgokd7NO
 GEjH1k5WUhqB228jDQXfBdKRoz81YesPNXe5g7PU7KFu44UdbaojTWYdzpFhen34NYGCzQebt
 OA6qi1yLYCEX88Wch9P/k0lTlkg/p1cwkkWZHLqUALaOAznkMjkWRQPepbJK6vIADQ/TjwrWB
 fY2chRM5//GcOeEXQRVcrILJDTWj/muZnpvb+ZchUKOv0eNeT7oNnqT9X2yhxuD7qEOx48hVW
 1Tjrhi4KT8bHGYkZcXiOjo7gz2MM1JAj8oFO5BtXb8uB/eutvmRXsJQ22j+1qFHc4MipuxZ/b
 MOe12SslitvGrSR0tlou6W9WOybS4M6gvAXfAfeTle4G/fmKpPItkX8IapIPue
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13/01/2020 12:45, Koen Vandeputte wrote:
> I'm more than happy to give this a thorough test on dozens of devices offshore
> 
> which I suspect are suffering from this issue as they sail in-out of range,
> 
> but as a new flag is defined in nl80211.h, is anything additional required at wpa_sup side to use this?

I use this blunt patch for now, until this issue settles.

Note that it only work in IBSS RSN case, because that's the only mode
where wpa_supplicant registers for auth frames (and thus the kernel doesn't
handle them) and does reboot detection.

diff --git a/wpa_supplicant/ibss_rsn.c b/wpa_supplicant/ibss_rsn.c
index 37368c4cb..026750161 100644
--- a/wpa_supplicant/ibss_rsn.c
+++ b/wpa_supplicant/ibss_rsn.c
@@ -353,7 +353,11 @@ static int auth_set_key(void *ctx, int vlan_id, enum wpa_alg alg,
 static void ibss_rsn_disconnect(void *ctx, const u8 *addr, u16 reason)
 {
 	struct ibss_rsn *ibss_rsn = ctx;
-	wpa_drv_sta_deauth(ibss_rsn->wpa_s, addr, reason);
+	struct ibss_rsn_peer *peer = ibss_rsn_get_peer(ibss_rsn, addr);
+	if (peer && wpa_drv_sta_remove(ibss_rsn->wpa_s, addr) == 0)
+		peer->authentication_status |= IBSS_RSN_PENDING_DELETION;
+	else
+		wpa_drv_sta_deauth(ibss_rsn->wpa_s, addr, reason);
 }


@@ -810,6 +814,13 @@ int ibss_rsn_rx_eapol(struct ibss_rsn *ibss_rsn, const u8 *src_addr,
 		return -1;

 	peer = ibss_rsn_get_peer(ibss_rsn, src_addr);
+	if (peer->authentication_status & IBSS_RSN_PENDING_DELETION) {
+		wpa_printf(MSG_DEBUG,
+			   "RSN: Ignoring RX EAPOL from removed peer " MACSTR,
+			   MAC2STR(src_addr));
+		return -1;
+	}
+
 	if (peer)
 		return ibss_rsn_process_rx_eapol(ibss_rsn, peer, buf, len);

@@ -849,6 +860,10 @@ static void ibss_rsn_handle_auth_1_of_2(struct ibss_rsn *ibss_rsn,
 {
 	wpa_printf(MSG_DEBUG, "RSN: IBSS RX Auth frame (SEQ 1) from " MACSTR,
 		   MAC2STR(addr));
+	if (peer && peer->authentication_status & IBSS_RSN_PENDING_DELETION) {
+		wpa_printf(MSG_DEBUG, "RSN: Ignoring auth from removed sta");
+		return;
+	}

 	if (peer &&
 	    peer->authentication_status & (IBSS_RSN_SET_PTK_SUPP |
@@ -883,8 +898,16 @@ static void ibss_rsn_handle_auth_1_of_2(struct ibss_rsn *ibss_rsn,
 		wpa_printf(MSG_DEBUG, "RSN: IBSS Reinitializing station "
 			   MACSTR, MAC2STR(addr));

-		ibss_rsn_stop(ibss_rsn, addr);
-		peer = NULL;
+		if (wpa_drv_sta_remove(ibss_rsn->wpa_s, addr) == 0) {
+			wpa_printf(MSG_DEBUG,
+				   "RSN: IBSS sta deletion requested.");
+			peer->authentication_status
+				|= IBSS_RSN_PENDING_DELETION;
+			return;
+		} else {
+			ibss_rsn_stop(ibss_rsn, addr);
+			peer = NULL;
+		}
 	}

 	if (!peer) {
@@ -935,6 +958,11 @@ void ibss_rsn_handle_auth(struct ibss_rsn *ibss_rsn, const u8 *auth_frame,
 				   "unknown STA " MACSTR, MAC2STR(header->sa));
 			break;
 		}
+		if (peer->authentication_status & IBSS_RSN_PENDING_DELETION) {
+			wpa_printf(MSG_DEBUG,
+				   "RSN: Ignoring auth from removed sta");
+			break;
+		}

 		/* authentication has been completed */
 		eloop_cancel_timeout(ibss_rsn_auth_timeout, peer, NULL);
diff --git a/wpa_supplicant/ibss_rsn.h b/wpa_supplicant/ibss_rsn.h
index 626c54354..17f5ca0ee 100644
--- a/wpa_supplicant/ibss_rsn.h
+++ b/wpa_supplicant/ibss_rsn.h
@@ -25,6 +25,8 @@ struct ibss_rsn;
 #define IBSS_RSN_SET_PTK_AUTH		0x10
 /* PTK completion reported */
 #define IBSS_RSN_REPORTED_PTK		0x20
+/* requested STA deletion to kernel */
+#define IBSS_RSN_PENDING_DELETION	0x40

 struct ibss_rsn_peer {
 	struct ibss_rsn_peer *next;
